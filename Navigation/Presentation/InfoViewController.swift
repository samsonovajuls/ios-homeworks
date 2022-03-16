//
//  InfoViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 03.03.2022.
//

import UIKit

class InfoViewController: UIViewController {

    private lazy var alertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Показать алерт", for: .normal)
        button.backgroundColor = .systemYellow
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(didTapAlertButton), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemGreen
        self.view.addSubview(self.alertButton)

        let alertButtonHeight = self.alertButton.heightAnchor.constraint(equalToConstant: 50)
        let alertButtonWidth = self.alertButton.widthAnchor.constraint(equalToConstant: 300)
        let alertButtonBottom = self.alertButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        let alertButtonCenterXConstraint = self.alertButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)

        NSLayoutConstraint.activate([
            alertButtonHeight, alertButtonWidth, alertButtonBottom, alertButtonCenterXConstraint
        ].compactMap({ $0 }))

    }

    @objc private func didTapAlertButton() {
        let alert = UIAlertController (title: "Внимание", message: "Здесь что то важное", preferredStyle: .actionSheet)
        let okAction = UIAlertAction (title: "Да", style: .default, handler: {action in print ("Да")} )
        let cancelAction = UIAlertAction (title: "Отмена", style: .cancel, handler: {action in print ("Отмена")})
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }

}
