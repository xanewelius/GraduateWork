//
//  SettingsViewController.swift
//  photosApp
//
//  Created by Max Kuzmin on 09.03.2023.
//

import UIKit

enum SettingsOptionType {
    case staticCell(model: SettingsOption)
    case switchCell(model: SettingsSwitchOption)
}

struct SettingsSwitchOption {
    let title: String
    let handler: (() -> Void)
}

struct SettingsOption {
    let title: String
    let handler: (() -> Void)
}

final class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let table = UITableView()
        table.separatorColor = .gray
        table.tableHeaderView = UIView(frame: .zero)
        //table.allowsSelection = true
        table.register(SettingsTableViewCell.self,
                       forCellReuseIdentifier: SettingsTableViewCell.identifier)
        table.register(SwitchTableViewCell.self,
                       forCellReuseIdentifier: SwitchTableViewCell.identifier)
        table.backgroundColor = .systemBackground
        return table
    }()
    
    var models = [SettingsOptionType]()
    
    private lazy var appDetailViewController: AppDetailViewController = {
        let detail = AppDetailViewController()
        return detail
    }()
    
    private lazy var profileDetailViewController: ProfileDetailViewController = {
        let detail = ProfileDetailViewController()
        return detail
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        tableView.delegate = self
        tableView.dataSource = self
        configureView()
    }
    
    let exitButton: UIButton = {
        var configuration = UIButton.Configuration.borderless()
        configuration.title = "Выйти"
        configuration.baseForegroundColor = .systemRed
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
}

private extension SettingsViewController {
    @objc func buttonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func configureView() {
        let font = UIFont(name: "Montserrat-Medium", size: 16)!
        let attributes = [NSAttributedString.Key.font: font]
        title = "Настройки"
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        view.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        view.addSubview(tableView)
        view.addSubview(exitButton)
        
        // Конфигурирование tableView и добавление моделей
        models.append(.staticCell(model: SettingsOption(title: "Пользователь") {
            self.navigationController?.pushViewController(self.profileDetailViewController, animated: true)
        }))
        models.append(.staticCell(model: SettingsOption(title: "О приложении") {
            self.navigationController?.pushViewController(self.appDetailViewController, animated: true)
        }))
        models.append(.switchCell(model: SettingsSwitchOption(title: "Темная тема", handler: {
            
        })))
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            exitButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            exitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        
        switch model.self {
        case .staticCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        case .switchCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SwitchTableViewCell.identifier, for: indexPath) as? SwitchTableViewCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.row]
        switch type.self {
        case .staticCell(let model):
            model.handler()
        case .switchCell(let model):
            model.handler() 
        }
    }
}
