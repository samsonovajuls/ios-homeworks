//
//  FeedViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 28.02.2022.
//

import UIKit

struct Post {
    var title: String
}

class FeedViewController: UIViewController {

    private lazy var button: UIButton = {
        let button = UIButton(frame: CGRect(x: (self.view.frame.size.width - 300)/2,
                                            y: self.view.frame.size.height - 180,
                                            width: 300,
                                            height: 50)
        )
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        self.navigationItem.title = "Лента"
        self.navigationItem.backButtonTitle = ""
        self.navigationController?.navigationBar.prefersLargeTitles = true

        self.view.addSubview(self.button)
    }

    @objc private func didTapButton(){
        let postViewController = PostViewController()
        postViewController.post = Post(title: "Пост 1")
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
