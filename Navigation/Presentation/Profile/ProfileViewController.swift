//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 28.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemGray6
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: "PostCell")
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()

    private lazy var jsonDecoder: JSONDecoder = {
        return JSONDecoder()
    }()

    private var dataSource: [News.Post] = []

    private var profileHeaderViewHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.fetchPosts { [weak self] posts in
            self?.dataSource = posts
            self?.tableView.reloadData()
        }

        self.tableView.tableHeaderView = profileHeaderView
        self.setupNavigationBar()
        self.setupTableView()
        self.setupProfileHeaderView()
        self.tapGesture()
    }

    private func setupNavigationBar() {
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setupTableView() {
        self.view.addSubview(self.tableView)

        let tableViewTopConstraint = self.tableView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let tableViewLeadingConstraint = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let tableViewTrailingConstraint = self.tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let tableViewBottomConstraint = self.tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)

        NSLayoutConstraint.activate([
            tableViewTopConstraint,
            tableViewLeadingConstraint,
            tableViewTrailingConstraint,
            tableViewBottomConstraint
        ])
    }

    private func setupProfileHeaderView() {
        self.view.backgroundColor = .white
        self.profileHeaderView.backgroundColor = .systemGray6

        let profileHeaderViewTopConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.tableView.topAnchor)
        let profileHeaderViewLeadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.tableView.leadingAnchor)
        let profileHeaderViewTrailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor)
        let profileHeaderViewWidthConstraint = self.profileHeaderView.widthAnchor.constraint(equalTo: tableView.widthAnchor)
        self.profileHeaderViewHeightConstraint = self.profileHeaderView.heightAnchor.constraint (equalToConstant: 220)
        let profileHeaderViewBottomConstraint = self.profileHeaderView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor)

        NSLayoutConstraint.activate([
            profileHeaderViewTopConstraint,
            profileHeaderViewLeadingConstraint,
            profileHeaderViewTrailingConstraint,
            profileHeaderViewWidthConstraint,
            self.profileHeaderViewHeightConstraint,
            profileHeaderViewBottomConstraint
        ].compactMap({ $0 }))
    }

    func tapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    private func fetchPosts(completion: @escaping ([News.Post]) -> Void) {
        if let path = Bundle.main.path(forResource: "news", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                let news = try self.jsonDecoder.decode(News.self, from: data)
                //print("json data: \(news)")
                completion(news.posts)
            } catch let error {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            fatalError("Invalid filename/path.")
        }
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateHeaderViewHeight(for: self.tableView.tableHeaderView)
    }

    private func updateHeaderViewHeight(for header: UIView?) {
        guard let header = header else { return }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: view.bounds.width, height: CGFloat(self.profileHeaderViewHeightConstraint!.constant))).height
    }
}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.tableView.beginUpdates()
        self.tableView.reloadSections(IndexSet(0..<1), with: .none)
        self.tableView.endUpdates()
        
        self.profileHeaderViewHeightConstraint?.constant = textFieldIsVisible ? 270 : 220

        UIView.animate(withDuration: 0.1, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }

        print("didTapStatusButton")

    }
}



extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as? PostTableViewCell else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DefaultCell", for: indexPath)
            return cell
        }

        let post = self.dataSource[indexPath.row]
        let viewModel = PostTableViewCell.ViewModel(author: post.author,
                                                    description: post.description,
                                                    image: post.image,
                                                    likes: post.likes,
                                                    views: post.views
        )
        cell.setup(with: viewModel)

        return cell
    }
}
