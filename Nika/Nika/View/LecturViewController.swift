//
//  LecturViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit

final class LecturViewController: UIViewController {
    
    //MARK: - Variables
    private let images = Image.getImageList()
    
    //MARK: - UIComponents
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Сell")
        return tableView
    }()
    
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Search on Unsplash"
        label.textColor = .gray
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
}

private extension LecturViewController {
    func configureView() {
        view.backgroundColor = .white
        //navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: searchTitle)
        //title = "Settings"
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 125
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

// MARK: - CollectionView

extension LecturViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сell", for: indexPath)
        let image = images[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = image.lecture
        content.secondaryText = image.description
        content.image = UIImage(named: "1")
        //content.imageProperties.cornerRadius = tableView.rowHeight
        cell.contentConfiguration = content
        
        return cell
    }
    
    
}
