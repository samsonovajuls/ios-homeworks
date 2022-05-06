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
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.isUserInteractionEnabled = true
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

    private lazy var transparentBackgroundView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.alpha = 0
        view.backgroundColor = .black
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var closeAvatarButton: UIButton = {
        let button = UIButton()
        let image = UIImage(named: "cross.png")
        button.setBackgroundImage(image, for: .normal)
        button.isHidden = true
        button.alpha = 0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeAvatar), for: .touchUpInside)
        return button
    }()

    private var centerXAvatarConstraint,
                centerYAvatarConstraint,
                widthAvatarConstraint,
                heightAvatarConstraint: NSLayoutConstraint?

    override init (frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemGray6
        self.drawSelf()
        self.setupGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func drawSelf() {
        self.addSubview(self.avatarImageView)
        self.addSubview(self.labelStackView)
        self.addSubview(self.statusButton)
        self.addSubview(self.statusTextField)

        self.labelStackView.addArrangedSubview(self.fullNameLabel)
        self.labelStackView.addArrangedSubview(self.statusLabel)
        self.addSubview(transparentBackgroundView)
        self.addSubview(closeAvatarButton)

        // задаем место и размеры для аватара
        self.centerXAvatarConstraint = self.avatarImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 66)
        self.centerYAvatarConstraint = self.avatarImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66)
        self.widthAvatarConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 100)
        self.heightAvatarConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 100)

        NSLayoutConstraint.activate([
            self.centerXAvatarConstraint,
            self.centerYAvatarConstraint,
            self.widthAvatarConstraint,
            self.heightAvatarConstraint
        ].compactMap( {$0} ))

        // отступы для стэка с лэйблами с именем и статусом
        NSLayoutConstraint.activate([
            self.labelStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 16),
            self.labelStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 132),
            self.labelStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
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
            self.statusButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            self.statusButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            self.statusButton.heightAnchor.constraint(equalToConstant: 50)
        ])

        // полупрозрачный фон для разворачивающейся аватарки
        NSLayoutConstraint.activate([
            self.transparentBackgroundView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width),
            self.transparentBackgroundView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.height)
        ])
        self.transparentBackgroundView.center = CGPoint(x: UIScreen.main.bounds.midX, y: UIScreen.main.bounds.midY)

        self.avatarImageView.layer.zPosition = 1

        // крестик для закрытия большой аватарки
        NSLayoutConstraint.activate([
            self.closeAvatarButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),
            self.closeAvatarButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            self.closeAvatarButton.widthAnchor.constraint(equalToConstant: 40),
            self.closeAvatarButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }

    private func setupGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAvatar))
        self.avatarImageView.addGestureRecognizer(tap)
    }

    @objc private func showAvatar() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transparentBackgroundView.isHidden = false
            self.closeAvatarButton.isHidden = false
            self.avatarImageView.layer.cornerRadius = 0
            self.transparentBackgroundView.alpha = 0.8

            NSLayoutConstraint.deactivate([
                self.centerXAvatarConstraint,
                self.centerYAvatarConstraint,
                self.heightAvatarConstraint,
                self.widthAvatarConstraint
            ].compactMap( {$0} ))

            let superviewFrame = (self.superview?.safeAreaLayoutGuide.layoutFrame)!
            self.centerXAvatarConstraint?.constant = superviewFrame.width / 2
            self.centerYAvatarConstraint?.constant = superviewFrame.height / 2

            let avatarWidth: CGFloat
            if superviewFrame.width < superviewFrame.height {
                avatarWidth = superviewFrame.width
            }
            else {
                avatarWidth = superviewFrame.height
            }
            self.widthAvatarConstraint?.constant = avatarWidth
            self.heightAvatarConstraint?.constant = avatarWidth

            NSLayoutConstraint.activate([
                self.centerXAvatarConstraint,
                self.centerYAvatarConstraint,
                self.heightAvatarConstraint,
                self.widthAvatarConstraint
            ].compactMap( {$0} ))

            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 0.3) {
                self.closeAvatarButton.alpha = 1
                self.layoutIfNeeded()
            }
        }
    }

    @objc private func closeAvatar() {
        UIView.animate(withDuration: 0.5, animations: {
            NSLayoutConstraint.deactivate([
                self.centerXAvatarConstraint,
                self.centerYAvatarConstraint,
                self.heightAvatarConstraint,
                self.widthAvatarConstraint
            ].compactMap( {$0} ))

            self.centerXAvatarConstraint = self.avatarImageView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 66)
            self.centerYAvatarConstraint = self.avatarImageView.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 66)
            self.widthAvatarConstraint = self.avatarImageView.widthAnchor.constraint(equalToConstant: 100)
            self.heightAvatarConstraint = self.avatarImageView.heightAnchor.constraint(equalToConstant: 100)

            NSLayoutConstraint.activate([
                self.centerXAvatarConstraint,
                self.centerYAvatarConstraint,
                self.heightAvatarConstraint,
                self.widthAvatarConstraint
            ].compactMap( {$0} ))

            self.avatarImageView.layer.cornerRadius = 50
            self.closeAvatarButton.alpha = 0
            self.transparentBackgroundView.alpha = 0
            self.layoutIfNeeded()
        }) { _ in
            UIView.animate(withDuration: 1) {
                self.transparentBackgroundView.isHidden = true
                self.closeAvatarButton.isHidden = true
            }
        }
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
