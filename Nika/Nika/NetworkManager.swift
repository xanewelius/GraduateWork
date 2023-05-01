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
import FirebaseAuth

class NetworkManager {
    static let shared = NetworkManager()
    
    private let database = Database.database().reference()
    private var course: [String] = []
    
    func fetchUsers(completion: @escaping ([User]) -> Void) {
        let userUID = Auth.auth().currentUser!.uid
        let usersRef = database.child("Users")
        usersRef.observe(.value) { snapshot in
            var users = [User]()
            if snapshot.hasChild(userUID) {
                if let userDict = snapshot.childSnapshot(forPath: userUID).value as? [String: Any],
                   let name = userDict["name"] as? String,
                   let coursesDict = userDict["courses"] as? [String: Any] {
                    var courses = [Courses]()
                    for (courseID, courseData) in coursesDict {
                        if let courseDict = courseData as? [String: Any],
                           let dateOfEnd = courseDict["date"] as? String {
                            let course = Courses(id: courseID, dateOfEnd: dateOfEnd)
                            courses.append(course)
                        }
                    }
                    let user = User(id: userUID, name: name, courses: courses)
                    users.append(user)
                }
            }
            completion(users)
        }
    }
    
    //func fetchCourses(for course: String ,completion: @escaping ([Course]) -> Void) {
    func fetchCourses(for userCoursesIds: [String], completion: @escaping ([Course]) -> Void) {
        let coursesRef = database.child("Courses")
        coursesRef.observe(.value) { snapshot in // заменяем observeSingleEvent на observe, что дает нам обновление в реальном времени
            var courses = [Course]()
            for child in snapshot.children {
                guard let snap = child as? DataSnapshot,
                      let courseDict = snap.value as? [String: Any],
                      let name = courseDict["name"] as? String,
                      let img = courseDict["img"] as? String else {
                    continue
                }
                if userCoursesIds.contains(snap.key) {
                    let course = Course(id: snap.key, name: name, img: img)
                    courses.append(course)
                }
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
