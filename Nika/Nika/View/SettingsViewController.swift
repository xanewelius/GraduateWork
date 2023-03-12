//
//  SettingsViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit

final class SettingsViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension SettingsViewController {
    func configureView() {
        view.backgroundColor = .systemBackground
        title = "Настройки"
        navigationController?.navigationBar.prefersLargeTitles = true
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            
        ])
    }
}

