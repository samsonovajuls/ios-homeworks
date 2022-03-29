//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 28.02.2022.
//

import UIKit



class ProfileViewController: UIViewController {

    private lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()


    private lazy var secondButton: UIButton = {
        let secondButton = UIButton()
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        secondButton.setTitle("Button without action", for: .normal)
        secondButton.titleLabel?.textColor = .white
        secondButton.backgroundColor = UIColor.systemBlue
        return secondButton
    } ()

    private var profileHeaderViewHeightConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.view.addSubview(self.profileHeaderView)
        self.view.addSubview(self.secondButton)
        self.profileHeaderView.backgroundColor = .lightGray

        let profileHeaderViewTopConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0)
        let profileHeaderViewLeadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let profileHeaderViewTrailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        self.profileHeaderViewHeightConstraint = self.profileHeaderView.heightAnchor.constraint (equalToConstant: 220)

        let secondButtonLeadingConstraint = self.secondButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let secondButtonTrailingConstraint = self.secondButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let secondButtonBottomConstraint = self.secondButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        let secondButtonHeight = self.secondButton.heightAnchor.constraint(equalToConstant: 50)

        NSLayoutConstraint.activate([
            profileHeaderViewTopConstraint, profileHeaderViewLeadingConstraint, profileHeaderViewTrailingConstraint, self.profileHeaderViewHeightConstraint,
            secondButtonLeadingConstraint, secondButtonTrailingConstraint, secondButtonBottomConstraint, secondButtonHeight
        ].compactMap({ $0 }))


        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

}

extension ProfileViewController: ProfileHeaderViewProtocol {

    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void) {
        self.profileHeaderViewHeightConstraint?.constant = textFieldIsVisible ? 270 : 220

        UIView.animate(withDuration: 0.3, delay: 0.0) {
            self.view.layoutIfNeeded()
        } completion: { _ in
            completion()
        }
    }
}


