//
//  LogInViewController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 18.03.2022.
//

import UIKit

class LogInViewController: UIViewController {

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
        loginButton.addTarget(self, action: #selector(didButtonTapped), for: .touchUpInside)

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
        self.scrollView.addSubview(self.stackView)

        self.stackView.addArrangedSubview(textFieldsStackView)
        self.stackView.addArrangedSubview(loginButton)

        self.textFieldsStackView.addArrangedSubview(self.emailOrPhoneTextField)
        self.textFieldsStackView.addArrangedSubview(self.passwordTextField)


        let scrollViewTopConstraint = self.scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        let scrollViewTrailingConstraint = self.scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        let scrollViewLeadingConstraint = self.scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let scrollViewBottomConstraint = self.scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)

        let vkImageViewTopConstraint = self.vkLogoImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 120)
        let vkImageViewCenterXConstraint = self.vkLogoImageView.centerXAnchor.constraint(equalTo: self.scrollView.safeAreaLayoutGuide.centerXAnchor)
        let vkImageViewHeight = self.vkLogoImageView.heightAnchor.constraint(equalToConstant: 100)
        let vkImageViewWidth = self.vkLogoImageView.widthAnchor.constraint(equalToConstant: 100)


        let stackViewTopConstraint = self.stackView.topAnchor.constraint(equalTo: self.vkLogoImageView.bottomAnchor, constant: 120)
        let stackViewCenterXConstraint = self.stackView.centerXAnchor.constraint(equalTo: self.scrollView.centerXAnchor)
        let stackViewLeadingConstraint = self.stackView.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor, constant: 16)
        let stackViewTrailingConstraint = self.stackView.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor, constant: -16)
        let stackViewBottomConstraint = self.stackView.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor)


        let textFieldsTopConstraint = self.textFieldsStackView.topAnchor.constraint(equalTo: self.stackView.topAnchor)
        let textFieldsTrailingConstraint = self.textFieldsStackView.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
        let textFieldsLeadingConstraint = self.textFieldsStackView.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)
        let textFieldsStackViewHeightConstraint = self.textFieldsStackView.heightAnchor.constraint(equalToConstant: 100)

        let loginButtonHeightConstraint = self.loginButton.heightAnchor.constraint(equalToConstant: 50)
        let loginButtonTrailingConstraint = self.loginButton.trailingAnchor.constraint(equalTo: self.stackView.trailingAnchor)
        let loginButtonLeadingConstraint = self.loginButton.leadingAnchor.constraint(equalTo: self.stackView.leadingAnchor)


        NSLayoutConstraint.activate([

            scrollViewTopConstraint,
            scrollViewTrailingConstraint,
            scrollViewLeadingConstraint,
            scrollViewBottomConstraint,

            vkImageViewTopConstraint,
            vkImageViewCenterXConstraint,
            vkImageViewWidth,
            vkImageViewHeight,

            stackViewTopConstraint,
            stackViewCenterXConstraint,
            stackViewLeadingConstraint,
            stackViewTrailingConstraint,
            stackViewBottomConstraint,

            textFieldsTopConstraint,
            textFieldsTrailingConstraint,
            textFieldsLeadingConstraint,
            textFieldsStackViewHeightConstraint,

            loginButtonHeightConstraint,
            loginButtonTrailingConstraint,
            loginButtonLeadingConstraint

        ].compactMap({ $0 }))

    }

    @objc private func didButtonTapped(){
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
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

}
