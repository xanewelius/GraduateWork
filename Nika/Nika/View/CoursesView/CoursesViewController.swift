//
//  CoursesViewController.swift
//  Nika
//
//  Created by Max Kuzmin on 20.03.2023.
//

import UIKit

final class CoursesViewController: UIViewController {
    
    private let lecture = LectureViewController()
    private let collectionInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    private var courses: [Course] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureView()
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchCourses { [weak self] courses in
            self?.courses = courses
            self?.collectionView.reloadData()
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 175)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isScrollEnabled = true
        collectionView.register(CoursesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .automatic
        return collectionView
    }()
    
    private let coursesAvailable: UILabel = {
        let label = UILabel()
        label.text = "Нет доступных курсов"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .gray
        return label
    }()
}

private extension CoursesViewController {
    func configureView() {
        view.backgroundColor = .white
        navigationItem.titleView = nil
        //navigationController?.navigationBar.prefersLargeTitles = true
        title = "Курсы"
        collectionView.delegate = self
        collectionView.dataSource = self
        view.addSubview(collectionView)
        view.addSubview(coursesAvailable)
        layout()
    }
    
    func layout() {
        NSLayoutConstraint.activate([
            coursesAvailable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            coursesAvailable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CoursesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(courses.count)
        if courses.count == 0 {
            coursesAvailable.isHidden = false
        } else {
            coursesAvailable.isHidden = true
        }
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CoursesCollectionViewCell else { return UICollectionViewCell() }
        
        let course = courses[indexPath.item]
        cell.configure(with: course)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let course = courses[indexPath.item]
        lecture.fetchData(course: course)
        collectionView.deselectItem(at: indexPath, animated: true)
        self.navigationController?.pushViewController(self.lecture, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        collectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        collectionInsets.top
    }
}
