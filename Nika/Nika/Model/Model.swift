//
//  Model.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import Foundation

// MARK: - Config
struct Config: Codable {
    let user: [User]
}

// MARK: - User
struct User: Codable {
    let name, login, password: String
    let spec: Int
}
