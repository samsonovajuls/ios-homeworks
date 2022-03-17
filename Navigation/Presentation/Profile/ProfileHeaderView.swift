//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Юлия Самсонова on 04.03.2022.


import UIKit

final class ProfileHeaderView: UIView {

    private lazy var image: UIImageView = {
        let imageView  = UIImageView(frame: CGRect(x: 16, y: 16, width: 100, height: 100))
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.image = UIImage(named: "cat.png")
        imageView.layer.cornerRadius = 50
        return imageView
    }()

    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Hipster cat"
        return label
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Some status"
        self.statusText = label.text ?? ""
        return label
    }()

    private lazy var statusButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set status", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()

    private var statusText: String = ""

    @objc private func buttonPressed() {
        print("Прошлое значение статуса было - \(statusLabel.text ?? ""), новое - \(statusText)")
        statusLabel.text = statusText
    }

    private lazy var textField: UITextField = {
        let textField = UITextField()

        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        textField.textColor = .black
        textField.layer.cornerRadius = 12
        textField.backgroundColor = .white
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor
        textField.text = statusLabel.text
        textField.addTarget(self, action: #selector(statusTextChanged), for: .editingChanged)

        textField.leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: textField.frame.height))
        textField.leftViewMode = .always

        return textField
    }()


    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text ?? ""
        print(#function, statusText)
    }

    override init (frame: CGRect) {
        super.init(frame: frame)
        self.drawSelf()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {

        self.addSubview(image)
        self.addSubview(nameLabel)
        self.addSubview(statusButton)
        self.addSubview(statusLabel)
        self.addSubview(textField)

        let nameLabelTopConstraint = nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 27)
        let nameLabelLeadingConstraint = nameLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16)

        let statusButtonTopConstraint = statusButton.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 56)
        let statusButtonleadingConstraint = statusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
        let statusButtonTrailingConstraint = statusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let statusButtonHeight = statusButton.heightAnchor.constraint(equalToConstant: 50)

        let statusLabelBottomConstraint = statusLabel.bottomAnchor.constraint(equalTo: statusButton.topAnchor, constant: -74)
        let statusLabelLeadingConstraint = statusLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 16)
        let statusLabelTrailingConstraint = statusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        let textFieldTopConstraint = textField.topAnchor.constraint(equalTo: statusLabel.bottomAnchor, constant: 10)
        let textFieldLeadingConstraint = textField.leadingAnchor.constraint(equalTo: statusLabel.leadingAnchor)
        let textFieldTrailingConstant = textField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
        let textFielsHeight = textField.heightAnchor.constraint(equalToConstant: 40)

        NSLayoutConstraint.activate([
            nameLabelTopConstraint,nameLabelLeadingConstraint,
            statusButtonTopConstraint, statusButtonHeight, statusButtonleadingConstraint, statusButtonTrailingConstraint,
            statusLabelBottomConstraint, statusLabelLeadingConstraint, statusLabelTrailingConstraint,
            textFieldTopConstraint, textFieldLeadingConstraint, textFieldTrailingConstant, textFielsHeight
        ].compactMap({ $0 }))

    }
}
