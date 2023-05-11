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
    private var users: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        configureView()
    }
    
    private func fetchData() {
        NetworkManager.shared.fetchUsers { users in
            self.users = users
            if let currentUser = users.first {
                NetworkManager.shared.fetchCourses(for: currentUser.courses.flatMap { [(id: $0.id, dateOfEnd: $0.dateOfEnd)] }) { courses in
                    self.courses = courses
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 350, height: 175)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isScrollEnabled = true
        collectionView.backgroundColor = .systemBackground
        collectionView.contentInsetAdjustmentBehavior = .automatic
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CoursesCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    private let coursesAvailable: UILabel = {
        let label = UILabel()
        label.text = "Нет доступных курсов"
        label.textColor = .gray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

private extension CoursesViewController {
    func configureView() {
        self.navigationItem.title = "Курcы"
        view.backgroundColor = .systemBackground
        let font = UIFont(name: "Montserrat-Medium", size: 16)
        let attributes = [NSAttributedString.Key.font: font!]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
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
        coursesAvailable.isHidden = !courses.isEmpty // isEmpty - проверка на пустой массив а ! - инверсия
        return courses.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? CoursesCollectionViewCell else { return UICollectionViewCell() }
        
        courses = courses.sorted(by: { $0.dateOfEnd < $1.dateOfEnd })
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
