//
//  LectureCollectionViewCell.swift
//  Nika
//
//  Created by Max Kuzmin on 02.04.2023.
//

import UIKit

class LectureCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    
    static let reuseIdentifier = "MyCollectionViewCell"
    private let images = Courses.getImageList()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
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
    
    func configure(with image: Image) {
        print(image)
        titleLabel.text = image.lecture
        descriptionLabel.text = image.description
        imageView.image = UIImage(named: "2")
    }
}

// MARK: - Layout

private extension LectureCollectionViewCell {
    func configureView() {
        contentView.backgroundColor = .systemGray6
        contentView.layer.cornerRadius = 8
        contentView.layer.masksToBounds = true
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(imageView)
        layout()
    }
    
    func layout() {
            NSLayoutConstraint.activate([
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                imageView.heightAnchor.constraint(equalToConstant: 100),
                imageView.widthAnchor.constraint(equalToConstant: 100),
                
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                
                descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
                descriptionLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
                descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
            ])
        }
}

