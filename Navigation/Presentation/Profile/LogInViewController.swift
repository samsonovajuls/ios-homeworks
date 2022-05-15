//
//  LogInViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 18.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

    private enum Constant {
        static let minSymbolsInPassword: Int = 5
        static let defaultLogin: String = "123@mail.ru"
        static let defaultPassword: String = "12345"
    }

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private lazy var vkLogoImageView: UIImageView = {
        let vkLogoImageView = UIImageView()
        vkLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        vkLogoImageView.image = UIImage(named: "vkLogo.png")
        return vkLogoImageView
    }()

    private lazy var textFieldsStackView: UIStackView = {
        let textFieldsStackView = UIStackView()
        textFieldsStackView.translatesAutoresizingMaskIntoConstraints = false
        textFieldsStackView.axis = .vertical
        textFieldsStackView.distribution = .fillEqually
        textFieldsStackView.spacing = 0
        textFieldsStackView.layer.borderWidth = 0.5
        textFieldsStackView.layer.borderColor = UIColor.lightGray.cgColor
        textFieldsStackView.layer.cornerRadius = 10
        textFieldsStackView.clipsToBounds = true

        return textFieldsStackView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.clipsToBounds = true
        return stackView
    }()

    private lazy var emailOrPhoneTextField: UITextField = {
        let emailOrPhoneTextField = UITextField()
        emailOrPhoneTextField.translatesAutoresizingMaskIntoConstraints = false
        emailOrPhoneTextField.borderStyle = .none
        emailOrPhoneTextField.backgroundColor = .systemGray6
        emailOrPhoneTextField.textColor = .black
        emailOrPhoneTextField.font = UIFont.systemFont(ofSize: 16)
        emailOrPhoneTextField.autocapitalizationType = .none
        emailOrPhoneTextField.placeholder = "Email or phone"
        emailOrPhoneTextField.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        emailOrPhoneTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: emailOrPhoneTextField.frame.height))
        emailOrPhoneTextField.leftViewMode = .always
        return emailOrPhoneTextField
    }()

    private lazy var passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 0.5
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.backgroundColor = .systemGray6
        passwordTextField.textColor = .black
        passwordTextField.font = UIFont.systemFont(ofSize: 16)
        passwordTextField.autocapitalizationType = .none
        passwordTextField.isSecureTextEntry = true
        passwordTextField.placeholder = "Password"
        passwordTextField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: passwordTextField.frame.height))
        passwordTextField.leftViewMode = .always
        return passwordTextField
    }()

    private lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 10
        loginButton.setBackgroundImage(UIImage(named: "blue_pixel.png"), for: UIControl.State.normal)
        loginButton.setTitle("Log In", for: .normal)
        loginButton.titleLabel?.textColor = .white
        loginButton.addTarget(self, action: #selector(didLoginButtonTapped), for: .touchUpInside)

        if loginButton.isSelected {
            loginButton.alpha = 0.8
        } else if loginButton.isHighlighted {
            loginButton.alpha = 0.8
        } else if !loginButton.isEnabled {
            loginButton.alpha = 0.8
        } else {
            loginButton.alpha = 1
        }
        return loginButton
    }()

    private lazy var warningLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemPink
        return label
    }()

    var topLoginButtonConstraint: NSLayoutConstraint?
    var topWarningLabelConstraint: NSLayoutConstraint?
    var leadingWarningLabelConstraint: NSLayoutConstraint?
    var trailingWarningLabelConstraint: NSLayoutConstraint?
    var heightWarningLabelConstraint: NSLayoutConstraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.drawSelf()
        self.setupNavigationBar()
        self.tapGesture()
    }

    private func setupNavigationBar() {
        self.navigationController?.navigationBar.isHidden = true
    }

    private func drawSelf(){
        self.view.backgroundColor = .white

        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.vkLogoImageView)
        self.scrollView.addSubview(self.textFieldsStackView)
        self.scrollView.addSubview(self.warningLabel)
        self.scrollView.addSubview(self.loginButton)

        self.textFieldsStackView.addArrangedSubview(self.emailOrPhoneTextField)
        self.textFieldsStackView.addArrangedSubview(self.passwordTextField)

        NSLayoutConstraint.activate([
            self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            self.scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            self.vkLogoImageView.topAnchor.constraint(equalTo: self.scrollView.topAnchor, constant: 120),
            self.vkLogoImageView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.vkLogoImageView.heightAnchor.constraint(equalToConstant: 100),
            self.vkLogoImageView.widthAnchor.constraint(equalToConstant: 100)
        ])

        NSLayoutConstraint.activate([
            self.textFieldsStackView.topAnchor.constraint(equalTo: self.vkLogoImageView.bottomAnchor, constant: 120),
            self.textFieldsStackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor),
            self.textFieldsStackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16),
            self.textFieldsStackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16),
            self.textFieldsStackView.heightAnchor.constraint(equalToConstant: 100)
        ])

        self.topLoginButtonConstraint = self.loginButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16)
        NSLayoutConstraint.activate([
            self.loginButton.heightAnchor.constraint(equalToConstant: 50),
            self.loginButton.trailingAnchor.constraint(equalTo: self.textFieldsStackView.trailingAnchor),
            self.loginButton.leadingAnchor.constraint(equalTo: self.textFieldsStackView.leadingAnchor),
            self.loginButton.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor),
            self.topLoginButtonConstraint
        ].compactMap( {$0} ))

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillShow(notification: NSNotification) {

        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            // если нет размера клавиатуры по любой причине - то ничего не делаем
            return
        }

        var shouldMoveViewUp = false

        let bottomOfLoginButton = self.loginButton.convert(self.loginButton.bounds, to: self.view).maxY + 5
        let topOfKeyboard = self.view.frame.height - keyboardSize.height

        if bottomOfLoginButton > topOfKeyboard {
            shouldMoveViewUp = true
        }

        if(shouldMoveViewUp) {
            let spaceUnderButton = self.view.frame.height - bottomOfLoginButton
            self.view.frame.origin.y = 0 - keyboardSize.height + spaceUnderButton
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }

    func tapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
        self.view.addGestureRecognizer(tapGesture)
    }

    @objc private func didLoginButtonTapped(){

        //self.navigationController?.pushViewController(ProfileViewController(), animated: true) //для отладки. Чтобы не вводить каждый раз логин с паролем

        let emailOrPhone = emailOrPhoneTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        warningLabel.text = ""

        var passwordFieldHaveError = false
        var emailOrPhoneFieldHaveError = false

        if emailOrPhone.isEmpty {
            emailOrPhoneFieldHaveError = true
        } else if !isValidEmail(email: emailOrPhone){
            emailOrPhoneFieldHaveError = true
            self.activateWarningFieldConstraints()
            warningLabel.text = "Некорректный email"
        }

        if password.isEmpty {
            passwordFieldHaveError = true
        } else {
            if password.count < Constant.minSymbolsInPassword {
                passwordFieldHaveError = true
                self.activateWarningFieldConstraints()
                warningLabel.text = "Пароль должен быть больше " + String(Constant.minSymbolsInPassword) + " символов"
            }
        }

        if !passwordFieldHaveError && !emailOrPhoneFieldHaveError {
            if emailOrPhone != Constant.defaultLogin || password != Constant.defaultPassword {
                emailOrPhoneFieldHaveError = true
                passwordFieldHaveError = true

                let alert = UIAlertController(title: "Ошибка", message: "Введены некорректный email или пароль. \r\n Подсказка проверяющему: надо ввести логин \"" + Constant.defaultLogin + "\", пароль \"" + Constant.defaultPassword + "\"", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }

        if warningLabel.text == "" {
            self.deactivateWarningFieldConstraints()
        }

        if emailOrPhoneFieldHaveError {
            emailOrPhoneTextField.backgroundColor = UIColor(named: "lightPinkColor")
        } else {
            emailOrPhoneTextField.backgroundColor = .systemGray6
        }

        if passwordFieldHaveError {
            passwordTextField.backgroundColor = UIColor(named: "lightPinkColor")
        } else {
            passwordTextField.backgroundColor = .systemGray6
        }

        if !emailOrPhoneFieldHaveError && !passwordFieldHaveError {
            self.navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }


    func activateWarningFieldConstraints(){
        self.topLoginButtonConstraint?.isActive = false

        self.topWarningLabelConstraint = self.warningLabel.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 10)
        self.trailingWarningLabelConstraint = self.warningLabel.trailingAnchor.constraint(equalTo: self.textFieldsStackView.trailingAnchor)
        self.leadingWarningLabelConstraint = self.warningLabel.leadingAnchor.constraint(equalTo: self.textFieldsStackView.leadingAnchor)
        self.heightWarningLabelConstraint = self.warningLabel.heightAnchor.constraint(equalToConstant: 30)
        self.topLoginButtonConstraint = self.loginButton.topAnchor.constraint(equalTo: self.warningLabel.bottomAnchor, constant: 16)

        NSLayoutConstraint.activate([
            self.topLoginButtonConstraint,
            self.topWarningLabelConstraint,
            self.trailingWarningLabelConstraint,
            self.leadingWarningLabelConstraint,
            self.heightWarningLabelConstraint
        ].compactMap( {$0} ))
    }

    func deactivateWarningFieldConstraints(){
        NSLayoutConstraint.deactivate([
            self.topLoginButtonConstraint,
            self.topWarningLabelConstraint,
            self.trailingWarningLabelConstraint,
            self.leadingWarningLabelConstraint,
            self.heightWarningLabelConstraint
        ].compactMap( {$0} ))

        self.topLoginButtonConstraint = self.loginButton.topAnchor.constraint(equalTo: self.textFieldsStackView.bottomAnchor, constant: 16)
        self.topLoginButtonConstraint?.isActive = true
    }

    func isValidEmail(email: String) -> Bool {

        let emailRegEx = "(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|\"(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21\\x23-\\x5b\\x5d-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])*\")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\\x01-\\x08\\x0b\\x0c\\x0e-\\x1f\\x21-\\x5a\\x53-\\x7f]|\\\\[\\x01-\\x09\\x0b\\x0c\\x0e-\\x7f])+)\\])"
        let emailPred = NSPredicate(format:"SELF MATCHES[c] %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
