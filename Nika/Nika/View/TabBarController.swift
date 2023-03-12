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
        guard let lectureImage = UIImage(systemName: "heart") else { return }
        guard let settingsImage = UIImage(systemName: "gearshape") else { return }
        
        viewControllers = [
            createNavigationController(vc: LecturViewController(), itemName: "Lecture", itemImage: lectureImage),
            createNavigationController(vc: LecturViewController(), itemName: "Settings", itemImage: settingsImage),
        ]
    }
    
    private func createNavigationController(vc: UIViewController, itemName: String, itemImage: UIImage) -> UIViewController {
        let navigationViewController = UINavigationController(rootViewController: vc)
        navigationViewController.tabBarItem.title = itemName
        navigationViewController.tabBarItem.image = itemImage
        return navigationViewController
    }
}

