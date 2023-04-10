//
//  NetworkManager.swift
//  Nika
//
//  Created by Max Kuzmin on 12.03.2023.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase

final class NetworkManager {
    static let shared = NetworkManager()
    
    private func configureFB() -> Firestore {
        var db: Firestore!
        let settings = FirestoreSettings ()
        Firestore.firestore().settings = settings
        db = Firestore.firestore()
        return db
    }
    
    func getPost(collection: String, docName: String, completion: @escaping (Document?) -> Void) {
        let db = configureFB()
        db.collection(collection).document(docName).getDocument(completion: { (document, error) in
            guard error == nil else { completion (nil); return }
            let doc = Document(field1: document?.get("field1") as! String, field2: document?.get("field2") as! String)
            completion(doc)
        })
    }
}
