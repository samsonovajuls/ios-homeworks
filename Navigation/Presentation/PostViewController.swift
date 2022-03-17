//
//  PostViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 01.03.2022.
//

import UIKit

class PostViewController: UIViewController {

    var post: Post? = nil
    
    override func viewDidLoad() {

        super.viewDidLoad()
        self.view.backgroundColor = .systemYellow
        if let post = post {
            self.navigationItem.title = post.title
        }
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.setRightBarButton(
            UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(didTapInfoIcon)), animated: true
        )
    }

    @objc private func didTapInfoIcon(){

        let infoViewController = InfoViewController()
        self.present(infoViewController, animated: true, completion: nil)

    }
}
