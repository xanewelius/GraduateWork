//
//  Image.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

struct Image {
    let description: String
    let lecture: String
    
    var title: String {
        "\(description) - \(lecture)"
    }
}

extension Image {
    static func getImageList() -> [Image] {
        [
            Image(description: "Alberto Ruiz", lecture: "7 Elements (Original Mix)"),
            Image(description: "Dave Wincent", lecture: "Red Eye (Original Mix)"),
            Image(description: "E-Spectro", lecture: "End Station (Original Mix)"),
            Image(description: "Edna Ann", lecture: "Phasma (Konstantin Yoodza Remix)"),
            Image(description: "Ilija Djokovic", lecture: "Delusion (Original Mix)"),
            Image(description: "John Baptiste", lecture: "Mycelium (Original Mix)"),
            Image(description: "Lane 8", lecture: "Fingerprint (Original Mix)"),
            Image(description: "Mac Vaughn", lecture: "Pink Is My Favorite Color (Alex Stein Remix)"),
            Image(description: "Metodi Hristov, Gallya", lecture: "Badmash (Original Mix)"),
            Image(description: "Veerus, Maxie Devine", lecture: "Nightmare (Original Mix)")
        ]
    }
}
