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
    private let collectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private var lectures: [Lecture] = []
    
    //MARK: - UIComponents
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 120)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(LectureCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .white
        collectionView.contentInsetAdjustmentBehavior = .automatic
        return collectionView
    }()
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    func fetchData(course: Course) {
        title = "Лекции / \(course.name)"
        NetworkManager.shared.fetchLectures(for: course.id) { [weak self] lectures in
            self?.lectures = lectures
            self?.collectionView.reloadData()
        }
    }
}

private extension LectureViewController {
    func configureView() {
        view.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - CollectionView
extension LectureViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        lectures.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? LectureCollectionViewCell else { return UICollectionViewCell() }
        
        let lecture = lectures[indexPath.row]
        cell.configure(with: lecture)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let lecture = lectures[indexPath.row]
        let lectureURL = lecture.link
        
        //lectureURL: https://drive.google.com/file/d/1tUk6dSavwL4-emKRVBFEsznTO916W1hU/view?usp=share_link
        let pattern = "/d/([a-zA-Z0-9-_]+)"
        guard let regex = try? NSRegularExpression(pattern: pattern),
              let match = regex.firstMatch(in: lectureURL, range: NSRange(location: 0, length: lectureURL.utf16.count)),
              let range = Range(match.range(at: 1), in: lectureURL) else {
            // failed to extract id from url
            return
        }
        //fileID: 1tUk6dSavwL4-emKRVBFEsznTO916W1hU
        let fileID = String(lectureURL[range])
        
        let videoURL = URL(string: "https://drive.google.com/uc?export=download&id=\(fileID)")

        // Create a player item
        let playerViewController = AVPlayerViewController()
        let playerItem = AVPlayerItem(url: videoURL!)

        // Create a player
        let player = AVPlayer(playerItem: playerItem)
        playerViewController.player = player

        // Present the player view controller
        present(playerViewController, animated: true) {
            playerViewController.player!.play()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionInsets.left
    }
}
