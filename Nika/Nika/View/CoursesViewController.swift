//
//  CoursesViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 20.03.2023.
//

import UIKit

final class CoursesViewController: UIViewController {
    
    private let images = Courses.getImageList()
    private let lecture = LectureViewController()
    private let collectionInsets = UIEdgeInsets(top: 5, left: 3, bottom: 5, right: 5)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        //tableView.separatorStyle = .singleLine
        //tableView.separatorColor = .gray
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Сell")
        return tableView
    }()
}

private extension CoursesViewController {
    func configureView() {
        view.backgroundColor = .white
        //navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: searchTitle)
        title = "Курсы"
        //navigationController?.navigationBar.size
        navigationController?.navigationBar.prefersLargeTitles = true
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

extension CoursesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Сell", for: indexPath)
        let image = images[indexPath.row]
        
        var content = cell.defaultContentConfiguration()
        content.text = image.course
        content.textProperties.font = .systemFont(ofSize: 20, weight: .semibold)
        content.textToSecondaryTextVerticalPadding = 20
        content.secondaryText = image.description
        content.secondaryTextProperties.font = .systemFont(ofSize: 12, weight: .light)
        content.prefersSideBySideTextAndSecondaryText = true
        //content.image = UIImage(named: "2")
        //content.imageToTextPadding = 15
        //content.imageProperties.cornerRadius = tableView.rowHeight
        //cell.backgroundColor = .gray
        cell.contentConfiguration = content
        //cell.separatorInset = collectionInsets
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let courses = images[indexPath.row]
        self.navigationController?.pushViewController(self.lecture, animated: true)
    }
}
