//
//  NetworkManager.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    
    let urlString = "https://8a0db355-d450-46e8-a23c-8f66ddb721d6.mock.pstmn.io/config"
    
    func getInfo() {
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data else { return }
            if let config = try? JSONDecoder().decode(Config.self, from: data) {
                print(config.user)
            } else {
                print(error)
            }
        }
        task.resume()
    }
}
