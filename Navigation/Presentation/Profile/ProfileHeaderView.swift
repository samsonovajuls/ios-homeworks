//
//  ProfileHeaderView.swift
//  Navigation
//
//  Created by Юлия Самсонова on 04.03.2022.


import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func didTapStatusButton(textFieldIsVisible: Bool, completion: @escaping () -> Void)
}

final class ProfileHeaderView: UIView {

    private var statusText: String = ""

    private var statusButtonTopConstraint: NSLayoutConstraint?

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
        button.setTitle("Редактировать статус", for: .normal)
        button.titleLabel?.textColor = .white
        button.backgroundColor = UIColor.systemBlue
        button.layer.cornerRadius = 4
        button.layer.shadowOffset.width = 4
        button.layer.shadowOffset.height = 4
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.7 // проверить
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(didTapStatusButton), for: .touchUpInside)
        return button
    }()

    private lazy var statusTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.isHidden = true
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
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        return stackView
    }()

    private lazy var infoStackView: UIStackView = {
        let infoStackView = UIStackView()
        infoStackView.axis = .horizontal
        infoStackView.spacing = 16
        infoStackView.translatesAutoresizingMaskIntoConstraints = false
        return infoStackView
    }()

    weak var delegate: ProfileHeaderViewProtocol?

    override init (frame: CGRect) {
        super.init(frame: frame)
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

        let topConstraint = self.infoStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
        let leadingConstraint = self.infoStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16)
        let trailingConstraint = self.infoStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)

        self.statusButtonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
        self.statusButtonTopConstraint?.priority = UILayoutPriority(rawValue: 999)

        let statusButtonLeadingConstraint = self.statusButton.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor)
        let statusButtonTrailingConstraint = self.statusButton.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)

        let statusButtonHeight = self.statusButton.heightAnchor.constraint(equalToConstant: 50)

        let imageViewHeight = self.avatarImageView.heightAnchor.constraint(equalToConstant: 100)
        let imageViewAspectRatio = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)

        NSLayoutConstraint.activate([
            topConstraint, leadingConstraint, trailingConstraint,
            imageViewHeight, imageViewAspectRatio,
            statusButtonTopConstraint, statusButtonLeadingConstraint, statusButtonTrailingConstraint, statusButtonHeight
        ].compactMap({ $0 }))
    }

    @objc private func didTapStatusButton() {

        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            self.statusButtonTopConstraint?.isActive = false

            let topConstraint = self.statusTextField.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10)
            let leadingConstraint = self.statusTextField.leadingAnchor.constraint(equalTo: self.statusLabel.leadingAnchor)
            let trailingConstraint = self.statusTextField.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor)
            let heightTextFieldConstraint = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)

            self.statusButtonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)

            NSLayoutConstraint.activate([
                topConstraint, leadingConstraint, trailingConstraint, heightTextFieldConstraint,
                self.statusButtonTopConstraint
            ].compactMap({ $0 }))

            self.statusButton.setTitle("Сохранить статус", for: .normal)
        } else {
            self.statusTextField.removeFromSuperview()
            self.statusButtonTopConstraint?.isActive = false
            self.statusButtonTopConstraint = self.statusButton.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 16)
            NSLayoutConstraint.activate([
                self.statusButtonTopConstraint
            ].compactMap({ $0 }))


            print("Прошлое значение статуса было - \(statusLabel.text ?? ""), новое - \(statusText)")
            statusLabel.text = statusText
            self.statusButton.setTitle("Редактировать статус", for: .normal)

        }

        self.delegate?.didTapStatusButton(textFieldIsVisible: self.statusTextField.isHidden) { [weak self] in
            self?.statusTextField.isHidden.toggle()
        }
    }


    @objc func statusTextChanged(_ textField: UITextField) {
        self.statusText = textField.text ?? ""
        print(#function, statusText)
    }

}
