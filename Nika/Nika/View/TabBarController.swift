//
//  TabBarController.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        setupTabBar()
    }
    
    private func setupTabBar() {
        guard let lectureImage = UIImage(systemName: "book") else { return }
        guard let settingsImage = UIImage(systemName: "gearshape") else { return }

        viewControllers = [
            createNavigationController(vc: CoursesViewController(), itemName: "Курсы", itemImage: lectureImage),
            createNavigationController(vc: SettingsViewController(), itemName: "Настройки", itemImage: settingsImage),
        ]
    }
    
    private func createNavigationController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: vc)
        navigationViewController.tabBarItem.title = itemName
        navigationViewController.tabBarItem.image = itemImage
        return navigationViewController
    }
}

