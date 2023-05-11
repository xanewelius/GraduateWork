//
//  LectureCollectionViewCell.swift
//  Nika
//
//  Created by Max Kuzmin on 02.04.2023.
//

import UIKit
import Nuke

class LectureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Medium", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.contentMode = .top
        label.font = UIFont(name: "Montserrat-Light", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 5
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configuration
    func configure(with lecture: Lecture) {
        titleLabel.text = lecture.name
        descriptionLabel.text = lecture.description
        self.imageView.image = UIImage(named: "2")
        let url = lecture.img
        async {
            do {
                let image = try await loadImage(url: url)
                self.imageView.image = image
            } catch {
                print(error)
                self.imageView.image = UIImage(named: "2")
            }
        }
    }

    func loadImage(url: String) async throws -> UIImage {
        let task = Task.init(priority: .high) {
            let task = ImagePipeline.shared.imageTask(with: URL(string: url)!)
            for await progress in task.progress {
                print("Updated progress: ", progress)
            }
            return try await task.image
        }
        return try await task.value
    }
}

// MARK: - Layout
private extension LectureCollectionViewCell {
    func configureView() {
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = .systemGray6
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageView)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -10),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 120),
            imageView.widthAnchor.constraint(equalToConstant: 150),
        ])
    }
}

