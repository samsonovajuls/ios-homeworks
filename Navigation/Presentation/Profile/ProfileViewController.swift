//
//  ProfileViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 28.02.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    lazy var profileHeaderView: ProfileHeaderView = {
        let view = ProfileHeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    } ()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationItem.title = "Профиль"
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.view.addSubview(self.profileHeaderView)
        self.profileHeaderView.backgroundColor = .lightGray
    }

    override func viewWillLayoutSubviews() {
        let topConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 150)
        let leadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0)
        let trailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0)
        let bottomConstraint = self.profileHeaderView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -90)

        NSLayoutConstraint.activate([topConstraint, leadingConstraint, trailingConstraint, bottomConstraint])
    }

}
