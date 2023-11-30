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
    @Published var allNoteList = [Note]()
    @Published var availableNoteList = [Note]()
    @Published var deletedNoteList = [Note]()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        $allNoteList
            .map { noteList in
                noteList.filter { $0.deletedAt == nil }
            }
            .assign(to: \.availableNoteList, on: self)
            .store(in: &cancellables)


            $allNoteList
                .map { noteList in
                    noteList.filter { $0.deletedAt != nil }
                }
                .assign(to: \.deletedNoteList, on: self)
                .store(in: &cancellables)

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
                    let nodes: [String:Note] = try JSONParser().decode(value)
                    self?.allNoteList = nodes.map { $0.value }
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
        var updateNote = note
        updateNote.updatedAt = .now

        return Just(updateNote)
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
}
