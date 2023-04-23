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
    
    func fetchCourses(completion: @escaping ([Course]) -> Void) {
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
    
    func fetchLectures(for courseId: String, completion: @escaping ([Lecture]) -> Void) {
        let lecturesRef = database.child("Lectures").child(courseId)
        lecturesRef.observe(.value) { snapshot in
            var lectures = [Lecture]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot,
                      let lectureDict = snap.value as? [String: Any],
                      let name = lectureDict["name"] as? String,
                      let img = lectureDict["img"] as? String,
                      let description = lectureDict["description"] as? String,
                      let link = lectureDict["link"] as? String else {
                    continue
                }
                let lecture = Lecture(id: snap.key, name: name, description: description, link: link, img: img)
                lectures.append(lecture)
            }
            completion(lectures)
        }
    }
}
