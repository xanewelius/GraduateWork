//
//  Model.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import Foundation

// MARK: - Config
struct Course: Codable {
    var id: String
    var name: String
    var img: String
    //var lectures: [Lecture]
}

struct Lecture: Codable {
    var id: String
    var videoLink: String
}
