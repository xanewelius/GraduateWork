//
//  Image.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

struct Image {
    let description: String
    let lecture: String
    let video: String
    
    var title: String {
        "\(description) - \(lecture)"
    }
}

extension Image {
    static func getImageList() -> [Image] {
        [
            Image(description: "Alberto Ruiz", lecture: "7 Elements (Original Mix)", video: "leonid"),
            Image(description: "Dave Wincent", lecture: "Red Eye (Original Mix)", video: "leonid"),
            Image(description: "E-Spectro", lecture: "End Station (Original Mix)", video: "leonid"),
            Image(description: "Edna Ann", lecture: "Phasma (Konstantin Yoodza Remix)", video: "leonid"),
            Image(description: "Ilija Djokovic", lecture: "Delusion (Original Mix)", video: "leonid"),
            Image(description: "John Baptiste", lecture: "Mycelium (Original Mix)", video: "leonid"),
            Image(description: "Lane 8", lecture: "Fingerprint (Original Mix)", video: "leonid"),
            Image(description: "Mac Vaughn", lecture: "Pink Is My Favorite Color (Alex Stein Remix)", video: "leonid"),
            Image(description: "Metodi Hristov, Gallya", lecture: "Badmash (Original Mix)", video: "leonid"),
            Image(description: "Veerus, Maxie Devine", lecture: "Nightmare (Original Mix)", video: "/Users/xanew/Desktop/dev/GraduateWork/Nika/Nika/video/leonid.mp4")
        ]
    }
}
