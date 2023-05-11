//
//  AppDetailViewController.swift
//  photosApp
//
//  Created by Max Kuzmin on 14.03.2023.
//

import UIKit

final class AppDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private let appTitle: UILabel = {
        let appTitle = UILabel()
        appTitle.translatesAutoresizingMaskIntoConstraints = false
        appTitle.text = "Версия приложения"
        appTitle.textColor = .gray
        return appTitle
    }()
    
    private let appVersion: UILabel = {
        let appVersion = UILabel()
        appVersion.translatesAutoresizingMaskIntoConstraints = false
        appVersion.text = "0.1 build 1"
        appVersion.textColor = .gray
        return appVersion
    }()
}

private extension AppDetailViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        title = "О приложении"
        view.addSubview(appTitle)
        view.addSubview(appVersion)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            appTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            appTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            appVersion.topAnchor.constraint(equalTo: appTitle.bottomAnchor, constant: 5),
            appVersion.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
}
