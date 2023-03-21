//
//  AuthorizationViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 14.03.2023.
//

import UIKit

final class AuthorizationViewController: UIViewController {
    
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        //NetworkManager.shared.getInfo()
    }
    
    private let logo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        image.image = UIImage(named: "logo")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var button: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Войти"
        configuration.buttonSize = .medium
        configuration.image = UIImage(systemName: "arrow.right")
        configuration.imagePlacement = .trailing
        configuration.imagePadding = 50
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    private let loginField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Логин"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Пароль"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
}

private extension AuthorizationViewController {
    func configureView() {
        view.backgroundColor = .white
        view.addSubview(logo)
        view.addSubview(loginField)
        view.addSubview(passwordField)
        view.addSubview(button)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            logo.bottomAnchor.constraint(equalTo: loginField.topAnchor, constant: -60),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginField.widthAnchor.constraint(equalToConstant: 260.0),
            passwordField.topAnchor.constraint(equalTo: loginField.bottomAnchor, constant: 20),
            passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordField.widthAnchor.constraint(equalToConstant: 260.0),
            button.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 20),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 220.0),
            button.heightAnchor.constraint(equalToConstant: 40.0)
        ])
    }
}

private extension AuthorizationViewController {
    func showAlert() {
            // create the alert
            let alert = UIAlertController(title: "Неправильный логин или пароль",
                                          message: "Хотите попробовать ещё раз?",
                                          preferredStyle: UIAlertController.Style.alert)
            // add the actions (buttons)
            alert.addAction(UIAlertAction(title: "Повторить", style: UIAlertAction.Style.default,handler: nil))
        
            alert.addAction(UIAlertAction(title: "Закрыть", style: UIAlertAction.Style.cancel, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    
    @objc func buttonTapped() {
        print("tap")
        let login = "1"
        let password = "1"
        if loginField.text == login && passwordField.text == password {
            let tab = TabBarController()
            tab.modalPresentationStyle = .fullScreen
            present(tab, animated: true)
        } else {
            showAlert()
        }
        //show(lecture, sender: self)
    }
}
