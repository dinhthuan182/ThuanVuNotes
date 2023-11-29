//
//  NoteRepository.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Firebase

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
            .observe(.value) { [weak self] data in
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
