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
    
    private let appVersion: UILabel = {
        let appVersion = UILabel()
        appVersion.text = "Версия приложения 1.0.4"
        appVersion.textColor = .gray
        appVersion.translatesAutoresizingMaskIntoConstraints = false
        return appVersion
    }()
    
    private let logo: UIImageView = {
        let image = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 50))
        image.image = UIImage(named: "logo_nika")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
}

private extension AppDetailViewController {
    func configureView() {
        title = "О приложении"
        view.backgroundColor = .systemBackground
        view.addSubview(logo)
        view.addSubview(appVersion)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 120),
            logo.heightAnchor.constraint(equalToConstant: 40),
            
            appVersion.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 15),
            appVersion.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
