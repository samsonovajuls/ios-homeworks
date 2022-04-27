//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Юлия Самсонова on 04.03.2022.


import UIKit

final class ProfileHeaderView: UIView {

    private var statusText: String = ""

    private lazy var avatarImageView: UIImageView = {
        let avatarImageView  = UIImageView()
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.borderWidth = 3
        avatarImageView.layer.borderColor = UIColor.white.cgColor
        avatarImageView.image = UIImage(named: "cat.png")
        avatarImageView.layer.cornerRadius = 50
        return avatarImageView
    }()

    private lazy var fullNameLabel: UILabel = {
        let fullNameLabel = UILabel()
        fullNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
        fullNameLabel.text = "Кот"
        return fullNameLabel
    }()

    private lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .gray
        label.text = "Мяу"
        self.statusText = label.text ?? ""
        return label
    }()

    private lazy var statusButton: UIButton = {
        var button = UIButton()
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
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        return button
    }()

    private lazy var statusTextField: UITextField = {
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

    private lazy var labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 60
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        return stackView
    }()

    private lazy var infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.spacing = 16
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        return infoStackView
    }()

    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        self.drawSelf()
    }


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {

        self.addSubview(self.infoStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.statusTextField)
        self.infoStackView.addArrangedSubview(self.avatarImageView)
        self.infoStackView.addArrangedSubview(self.labelStackView)

        self.labelStackView.addArrangedSubview(self.fullNameLabel)
        self.labelStackView.addArrangedSubview(self.statusLabel)

        // стэк с аватаром и стэком, который содержит лэйблы с именем и статусом
        NSLayoutConstraint.activate([
            self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            self.infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ])

        // задаем размеры аватара
        NSLayoutConstraint.activate([
            self.avatarImageView.heightAnchor.constraint(equalToConstant: 100),
            self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
        ])

        // отступы для стэка с лэйблами с именем и статусом
        NSLayoutConstraint.activate([
            self.labelStackView.topAnchor.constraint(equalTo: self.infoStackView.topAnchor),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 16),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.labelStackView.heightAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            self.statusLabel.heightAnchor.constraint(equalToConstant: 20)
        ])

        // текстфилд для статуса
        NSLayoutConstraint.activate([
            self.statusTextField.topAnchor.constraint(equalTo: self.labelStackView.bottomAnchor, constant: 10),
            self.statusTextField.leadingAnchor.constraint(equalTo: self.labelStackView.leadingAnchor),
            self.statusTextField.trailingAnchor.constraint(equalTo: self.labelStackView.trailingAnchor),
            self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        ])

        // кнопка изменения статуса
        NSLayoutConstraint.activate([
            self.statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16),
            self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc private func didTapStatusButton() {
            print("Прошлое значение статуса было - \(statusLabel.text ?? ""), новое - \(statusText)")
            statusLabel.text = statusText
    }

    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text ?? ""
        print(#function, statusText)
    }

}
