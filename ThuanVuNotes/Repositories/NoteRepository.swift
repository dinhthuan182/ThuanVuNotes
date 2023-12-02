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
    @Published var allNotes = [Note]()
    @Published var availableNotes = [Note]()
    @Published var mineDeletedNotes = [Note]()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        /// Filter all users' avaliable notes (including mine) from `allNotes` to` availableNotes`
        $allNotes
            .map { notes in
                notes.filter { $0.deletedAt == nil }
            }
            .map { [weak self] notes in
                self?.sortedByUpdated(notes) ?? []
            }
            .assign(to: \.availableNotes, on: self)
            .store(in: &cancellables)

        /// Filter mine deleted notes from `allNotes` to `mineDeletedNotes`
        let userId = Auth.auth().currentUser?.uid
        $allNotes
            .map { notes in
                notes.filter { $0.deletedAt != nil && $0.ownerId == userId }
            }
            .map { [weak self] notes in
                self?.sortedByUpdated(notes) ?? []
            }
            .assign(to: \.mineDeletedNotes, on: self)
            .store(in: &cancellables)

        fetchNote()
    }

    // MARK: Functions
    func fetchNote() {
        reference
            .observe(.value) { [weak self] snapshot in
                guard let value = snapshot.value,
                    !(value is NSNull) else {
                    return
                }

                do {
                    let nodes: [String:Note] = try JSONParser().decode(value)
                    self?.allNotes = nodes.map { $0.value }
                } catch { }
            }
    }

    func addNote(_ note: Note) -> AnyPublisher<Any, Error> {
        Just(note)
            .tryMap { try JSONParser().encode($0) }
            .compactMap { [weak self] dictionary in
                self?.reference.child(note.id).setValue(dictionary)
            }
            .eraseToAnyPublisher()
    }

    func updateNote(_ note: Note) -> AnyPublisher<Any, Error> {
        return Just(note)
            .tryMap { try JSONParser().encode($0) }
            .compactMap { [weak self] dictionary in
                self?.reference.child(note.id).setValue(dictionary)
            }
            .eraseToAnyPublisher()
    }

    func deleteNote(_ note: Note) -> AnyPublisher<Any, Error> {
        var deleteNote = note
        deleteNote.deletedAt = .now

        return Just(deleteNote)
            .tryMap { try JSONParser().encode($0) }
            .compactMap { [weak self] dictionary in
                self?.reference.child(note.id).setValue(dictionary)
            }
            .eraseToAnyPublisher()
    }

    func recoverNote(_ note: Note) -> AnyPublisher<Any, Error> {
        var recoverNote = note
        recoverNote.deletedAt = nil

        return Just(recoverNote)
            .tryMap { try JSONParser().encode($0) }
            .compactMap { [weak self] dictionary in
                self?.reference.child(note.id).setValue(dictionary)
            }
            .eraseToAnyPublisher()
    }


    // Sort note by update
    private func sortedByUpdated(_ notes: [Note]) -> [Note] {
        notes.sorted {
            guard let first = $0.updatedAt,
                  let second = $1.updatedAt else {
                return false
            }

            return first > second
        }
    }
}
