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

struct Courses {
    let description: String
    let course: String
    
    var title: String {
        "\(description) - \(course)"
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
            Image(description: "Veerus, Maxie Devine", lecture: "Nightmare (Original Mix)", video: "/Users/xanew/Desktop/dev/GraduateWork/Nika/Nika/video/leonid.mp4")
        ]
    }
}

extension Courses {
    static func getImageList() -> [Courses] {
        [
            Courses(description: "12.02.23 - 24.04.23", course: "Шахтер"),
            Courses(description: "12.02.23 - 24.04.23", course: "Сварщик"),
            Courses(description: "12.02.23 - 24.04.23", course: "Монтажник")
        ]
    }
}
