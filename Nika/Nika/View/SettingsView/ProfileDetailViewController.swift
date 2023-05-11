//
//  ProfileDetailViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 16.03.2023.
//

import UIKit

final class ProfileDetailViewController: UIViewController {
    
    var courses: Course?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        fetchUser()
    }
    
    func fetchUser() {
        NetworkManager.shared.fetchUsers { users in
            if let currentUser = users.first {
                NetworkManager.shared.fetchCourses(for: currentUser.courses.flatMap { [(id: $0.id, dateOfEnd: $0.dateOfEnd)] }) { courses in
                    self.nameLabel.text = currentUser.name
                    self.courses = courses.first
                    self.specialityLabel.text = courses.map { $0.name }.joined(separator: ", ")
                }
            }
        }
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
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .systemGray
        label.font = UIFont(name: "Montserrat-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let specialityTitle: UILabel = {
        let label = UILabel()
        label.text = "Доступные курсы"
        label.font = UIFont(name: "Montserrat-Medium", size: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var specialityLabel: UILabel = {
        let label = UILabel()
        label.text = "-"
        label.textColor = .systemGray
        label.font = UIFont(name: "Montserrat-Light", size: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

extension ProfileDetailViewController {
    private func configureView() {
        view.backgroundColor = .systemBackground
        title = "Пользователь"
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
