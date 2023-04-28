//
//  ProfileDetailViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 16.03.2023.
//

import UIKit

final class ProfileDetailViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private let imageProfile: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bmo_black")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameTitle: UILabel = {
        let label = UILabel()
        label.text = "ФИО"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialityTitle: UILabel = {
        let label = UILabel()
        label.text = "Доступные курсы"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialityLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension ProfileDetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        view.addSubview(imageProfile)
        view.addSubview(nameTitle)
        view.addSubview(nameLabel)
        view.addSubview(specialityTitle)
        view.addSubview(specialityLabel)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            imageProfile.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            imageProfile.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //imageProfile.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            nameTitle.topAnchor.constraint(equalTo: imageProfile.bottomAnchor, constant: 20),
            nameTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.topAnchor.constraint(equalTo: nameTitle.bottomAnchor, constant: 5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            specialityTitle.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            specialityTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            specialityLabel.topAnchor.constraint(equalTo: specialityTitle.bottomAnchor, constant: 5),
            specialityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}
