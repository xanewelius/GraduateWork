//
//  LecturViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit
import AVKit

final class LectureViewController: UIViewController {
    
    //MARK: - Variables
    private let images = Image.getImageList()
    //private let video =
    
    //MARK: - UIComponents
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.separatorColor = .gray
        
        tableView.tableHeaderView = UIView(frame: .zero)
        
        tableView.allowsSelection = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Сell")
        return tableView
    }()
    
    private let searchTitle: UILabel = {
        let label = UILabel()
        label.text = "Lectrure"
        label.textColor = .black
        return label
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        NetworkManager.shared.getInfo()
    }
}

private extension LectureViewController {
    func configureView() {
        view.backgroundColor = .white
        //navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: searchTitle)
        title = "Лекции"
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

// MARK: - CollectionView

extension LectureViewController: UITableViewDelegate, UITableViewDataSource {
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
        content.textToSecondaryTextVerticalPadding = 5
        //content.imageToTextPadding = 15
        //content.imageProperties.cornerRadius = tableView.rowHeight
        cell.contentConfiguration = content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let video = images[indexPath.row]
        
        //let urlPath = Bundle.main.path(forResource: "leonid", ofType: "mp4")
        //print(urlPath)
        guard let url = URL(string: "file:///Users/xanew/Downloads/leonid.mp4") else { return }
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}
