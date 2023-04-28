//
//  Model.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import Foundation

// MARK: - Config
struct User: Codable {
    let id: String // user UID
    let name: String // Kuzmin Maxim Alexandrovich
    let courses: String // 101, 102, 103
}

struct Course: Codable {
    let id: String // 101
    let name: String // Шахтер
    let img: String // link on img
}

struct Lecture: Codable {
    let id: String // 101
    let name: String // Лекция номер 1
    let description: String // Описание лекции 1
    let link: String // link on google disk
    let img: String // ling on img
}
