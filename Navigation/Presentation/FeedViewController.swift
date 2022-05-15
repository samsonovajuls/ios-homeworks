//
//  FeedViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 28.02.2022.
//

import UIKit

struct SomePost {
    var title: String
}

class FeedViewController: UIViewController {

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var firstButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        return button
    }()

    private lazy var secondButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Перейти на пост", for: .normal)
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
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

        self.view.addSubview(verticalStackView)
        self.verticalStackView.addArrangedSubview(firstButton)
        self.verticalStackView.addArrangedSubview(secondButton)

        let verticalStackViewCenterXConstraint = self.verticalStackView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let verticalStackViewCenterYConstraint = self.verticalStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)

        let firstButtonHeight = self.firstButton.heightAnchor.constraint(equalToConstant: 50)
        let firstButtonWidth = self.firstButton.widthAnchor.constraint(equalToConstant: 300)

        let secondButtonHeight = self.secondButton.heightAnchor.constraint(equalToConstant: 50)
        let secondButtonWidth = self.secondButton.widthAnchor.constraint(equalToConstant: 300)

        NSLayoutConstraint.activate([
            verticalStackViewCenterXConstraint, verticalStackViewCenterYConstraint,
            firstButtonHeight, firstButtonWidth,
            secondButtonHeight, secondButtonWidth
        ].compactMap({ $0 }))
    }

    @objc private func didTapButton(){
        let postViewController = SomePostViewController()
        postViewController.post = SomePost(title: "Пост 1")
        self.navigationController?.pushViewController(postViewController, animated: true)
    }

}
