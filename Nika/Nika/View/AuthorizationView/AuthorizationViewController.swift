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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        self.termsTextView.delegate = self
    }
    
    private let logo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private var labelLogin: UILabel = {
        let label = UILabel()
        label.text = "Вход"
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var labelLoginDescription: UILabel = {
        let label = UILabel()
        label.text = "Войдите в свой аккаунт"
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Войти"
        configuration.buttonSize = .medium
        configuration.attributedTitle?.font = .systemFont(ofSize: 15, weight: .semibold)
        
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
    
    private let termsTextView: UITextView = {
        let policyText = "политикой конфиденциальности"
        let signatureText = "соглашением об электронной подписи"
        let attributedString = NSMutableAttributedString(string: "Нажимая кнопку \"Войти\", Вы соглашаетесь с \(policyText) и \(signatureText)")
        attributedString.addAttribute(.link, value: "policy://privacyPolicy", range: (attributedString.string as NSString).range(of: policyText))
        attributedString.addAttribute(.link, value: "agreement://termsAndConditions", range: (attributedString.string as NSString).range(of: signatureText))
        let text = UITextView()
        text.attributedText = attributedString
        text.linkTextAttributes = [.foregroundColor: UIColor.systemBlue]
        text.font = .systemFont(ofSize: 10)
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
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(labelLogin)
        view.addSubview(labelLoginDescription)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        passwordField.rightView = toggleButton
        passwordField.rightViewMode = .always
        view.addSubview(toggleButton)
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
            button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
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
    
    @objc func buttonTapped() {
        print("tap")
        guard let email = loginField.text else { return }
        guard let password = passwordField.text else { return }
        print(email, password)
        let tab = TabBarController()
        tab.modalPresentationStyle = .fullScreen
        self.present(tab, animated: true)
        
        Auth.auth().signIn(withEmail: email, password: password) { [self] result, error in
            if error == nil {
                let tab = TabBarController()
                tab.modalPresentationStyle = .fullScreen
                self.present(tab, animated: true)
            } else {
                print(error!.localizedDescription)
                if email == "" || password == "" {
                    self.showAlert(title: "Введите логин и пароль", message: "Хотите повторить еще раз?")
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
