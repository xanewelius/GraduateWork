//
//  AuthorizationViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 14.03.2023.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

final class AuthorizationViewController: UIViewController {
    
    private let defaults = UserDefaults.standard
    private let settings = SwitchTableViewCell()
    private var email = ""
    private var password = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settings.checkForSwitchPreference()
        configureView()
        checkForSwitchPreference()
        self.termsTextView.delegate = self
    }
    
    private let logo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        image.image = UIImage(named: "logo_nika")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = UIFont(name: "Montserrat-Bold", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var labelLoginDescription: UILabel = {
        let label = UILabel()
        label.text = "Войдите в свой аккаунт"
        label.font = UIFont(name: "Montserrat-Light", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Войти"
        configuration.buttonSize = .medium
        configuration.attributedTitle?.font = UIFont(name: "Montserrat-Medium", size: 15)
        //configuration.image = UIImage(systemName: "arrow.right")
        //configuration.imagePlacement = .trailing
        //configuration.imagePadding = 50
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.font = UIFont(name: "Montserrat-Light", size: 17)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        
        //выключает замену первой буквы на большую (Автокапитализация)
        textField.autocapitalizationType = .none
        //выключает автокоррекцию текста
        textField.autocorrectionType = .no
        //выключает замену двух дефисов на тире
        textField.smartDashesType = .no
        //выключает замену кавычек
        textField.smartQuotesType = .no
        //выключает подсказки сверху
        textField.smartInsertDeleteType = .no
        
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.font = UIFont(name: "Montserrat-Light", size: 17)
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
        textField.leftViewMode = .always
        textField.layer.cornerRadius = 10
        textField.clipsToBounds = true
        
        //делает текст скрытым
        textField.isSecureTextEntry = true
        //выключает замену первой буквы на большую (Автокапитализация)
        textField.autocapitalizationType = .none
        //выключает автокоррекцию текста
        textField.autocorrectionType = .no
        //выключает замену двух дефисов на тире
        textField.smartDashesType = .no
        //выключает замену кавычек
        textField.smartQuotesType = .no
        //выключает подсказки сверху
        textField.smartInsertDeleteType = .no
        
        textField.backgroundColor = .systemGray6
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var toggleButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "eye", withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
        configuration.buttonSize = .mini
        let button = UIButton(configuration: configuration)
        button.addTarget(self, action: #selector(togglePasswordVisibility), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let checkBoxButton: UIButton = {
        let checkboxButton = UIButton(type: .custom)
        checkboxButton.translatesAutoresizingMaskIntoConstraints = false
        checkboxButton.setImage(UIImage(systemName: "square"), for: .normal)
        checkboxButton.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
        checkboxButton.addTarget(self, action: #selector(checkBoxTapped), for: .touchUpInside)
        return checkboxButton
    }()
    
    private let checkboxLabel: UILabel = {
        let label = UILabel()
        label.text = "Запомнить пользователя"
        label.font = UIFont(name: "Montserrat-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let checkboxStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 8
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let termsTextView: UITextView = {
        let policyText = "политикой конфиденциальности"
        let signatureText = "соглашением об электронной подписи"
        let attributedString = NSMutableAttributedString(string: "Нажимая кнопку \"Войти\", Вы соглашаетесь с \(policyText) и \(signatureText)")
        attributedString.addAttribute(.link, value: "policy://privacyPolicy", range: (attributedString.string as NSString).range(of: policyText))
        attributedString.addAttribute(.link, value: "agreement://termsAndConditions", range: (attributedString.string as NSString).range(of: signatureText))
        
        let text = UITextView()
        text.attributedText = attributedString
        text.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        text.font = UIFont(name: "Montserrat-Light", size: 10)
        text.textColor = .label
        text.isSelectable = true
        text.isEditable = false
        text.isScrollEnabled = false
        text.delaysContentTouches = false
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
}

private extension AuthorizationViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(logo)
        view.addSubview(labelLogin)
        view.addSubview(labelLoginDescription)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        passwordField.rightView = toggleButton
        passwordField.rightViewMode = .always
        view.addSubview(toggleButton)
        view.addSubview(checkboxStackView)
        checkboxStackView.addArrangedSubview(checkBoxButton)
        checkboxStackView.addArrangedSubview(checkboxLabel)
        view.addSubview(button)
        view.addSubview(termsTextView)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            logo.bottomAnchor.constraint(equalTo: labelLogin.topAnchor),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.heightAnchor.constraint(equalToConstant: 220),
            
            labelLogin.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelLoginDescription.topAnchor.constraint(equalTo: labelLogin.bottomAnchor, constant: 10),
            labelLoginDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelLoginDescription.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -20),
            
            loginField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.widthAnchor.constraint(equalToConstant: 340.0),
            loginField.heightAnchor.constraint(equalToConstant: 50.0),
            
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 20),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 340.0),
            passwordField.heightAnchor.constraint(equalToConstant: 50.0),
            
            checkboxStackView.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10),
            checkboxStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            button.topAnchor.constraint(equalTo: checkboxStackView.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 340.0),
            button.heightAnchor.constraint(equalToConstant: 50.0),
            
            termsTextView.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 5),
            termsTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            termsTextView.widthAnchor.constraint(equalToConstant: 340)
        ])
    }
}

private extension AuthorizationViewController {
    @objc private func togglePasswordVisibility() {
        // Изменяем состояние кнопки и свойство isSecureTextEntry
        passwordField.isSecureTextEntry.toggle()
        let imageName = passwordField.isSecureTextEntry ? "eye" : "eye.fill"
        toggleButton.configuration?.image = UIImage(systemName: imageName, withConfiguration: UIImage.SymbolConfiguration(pointSize: 12))
    }
    
    @objc func checkBoxTapped() {
        // меняет состояние
        checkBoxButton.isSelected = !checkBoxButton.isSelected
        userDefaultsConfig()
    }
    
    @objc func buttonTapped() {
        print("tap")
        email = loginField.text ?? ""
        password = passwordField.text ?? ""
        let tabBarController = TabBarController()
        if checkBoxButton.isSelected {
            userDefaultsConfig()
        }
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: true)
        
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error == nil {
                let tabBarController = TabBarController()
                tabBarController.modalPresentationStyle = .fullScreen
//                if checkBoxButton.isSelected {
//                    userDefaultsConfig()
//                }
                self.present(tabBarController, animated: true)
            } else {
                print(error!.localizedDescription)
                guard let email = loginField.text, !email.isEmpty,
                      let password = passwordField.text, !password.isEmpty else {
                    showAlert(title: "Введите логин и пароль", message: "Хотите повторить еще раз?")
                    return
                }
                switch error!.localizedDescription {
                case "The password is invalid or the user does not have a password.":
                    self.showAlert(title: "Неправильный пароль", message: "Хотите повторить еще раз?")
                case "The email address is badly formatted.":
                    self.showAlert(title: "Неправильная почта", message: "Хотите повторить еще раз?")
                case "There is no user record corresponding to this identifier. The user may have been deleted.":
                    self.showAlert(title: "Данного пользователя не существует", message: "Хотите повторить еще раз?")
                default:
                    self.showAlert(title: "Нет подключения к интернету", message: "Хотите повторить еще раз?")
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        // create the alert
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        // add the actions (buttons)
        alert.addAction(UIAlertAction(title: "Повторить", style: UIAlertAction.Style.default,handler: { _ in
            self.buttonTapped()
        } ))
        alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.cancel, handler: nil))
        // show the alert
        self.present(alert, animated: true, completion: nil)
    }
}

extension AuthorizationViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.scheme == "policy" {
            DispatchQueue.main.async {
                self.showWebViewerController(with: "https://cdoprof.com/sample_policy.pdf")
            }
        } else if URL.scheme == "agreement" {
            DispatchQueue.main.async {
                self.showWebViewerController(with: "https://cdoprof.com/ds_agreement.pdf")
            }
        }
        return false
    }
    
    private func showWebViewerController(with urlString: String) {
        DispatchQueue.main.async {
            let vc = WebViewerController(with: urlString)
            let nav = UINavigationController(rootViewController: vc)
            self.present(nav, animated: true, completion: nil)
        }
    }
}

extension AuthorizationViewController {
    func userDefaultsConfig() {
        defaults.set(checkBoxButton.isSelected, forKey: "setCheck")
        defaults.set(email, forKey: "setEmail")
        defaults.set(password, forKey: "setPassword")
    }
    
    func checkForSwitchPreference() {
        checkBoxButton.isSelected = defaults.bool(forKey: "setCheck")
        guard let savedEmail = defaults.string(forKey: "setEmail"),
              let savedPassword = defaults.string(forKey: "setPassword") else {
            return
        }
        loginField.text = savedEmail
        passwordField.text = savedPassword
    }
}
