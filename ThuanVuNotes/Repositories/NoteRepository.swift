//
//  NoteRepository.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Firebase
import Combine

// MARK: NoteRepository
class NoteRepository: ObservableObject {
    // MARK: Properties
    var reference: DatabaseReference {
        Database.database().reference().child("notes")
    }
    @Published var notes = [Note]()

    // MARK: Initialization
    init() {
        fetchNote()
    }

    // MARK: Functions
    func fetchNote() {
        reference
            .observe(.value) { [weak self] snapshot in
                guard let value = snapshot.value else {
                    return
                }

                do {
                    let data = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let nodes = try JSONDecoder().decode([String:Note].self, from: data)
                    self?.notes = nodes.map { $0.value }
                } catch { }
            }
    }

    func addNote(_ note: Note) {

    }

    func updateNote(_ note: Note) {

    }

    func deleteNote(_ note: Note) {

    }

    func recoverNote(_ note: Note) {
        
    }
}
