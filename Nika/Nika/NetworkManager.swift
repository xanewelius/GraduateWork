//
//  NetworkManager.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit
import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase

class NetworkManager {
    static let shared = NetworkManager()

    private let database = Database.database().reference()

    func fetchData(completion: @escaping ([Course]) -> Void) {
        let coursesRef = database.child("Courses")
        coursesRef.observe(.value) { snapshot in // заменяем observeSingleEvent на observe
            var courses = [Course]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot,
                      let courseDict = snap.value as? [String: Any],
                      let name = courseDict["name"] as? String,
                      let img = courseDict["img"] as? String else {
                    continue
                }
                let course = Course(id: snap.key, name: name, img: img)
                courses.append(course)
            }
            completion(courses)
        }
    }
}
