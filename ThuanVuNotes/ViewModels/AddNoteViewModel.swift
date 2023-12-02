//
//  AddNoteViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Combine

// MARK: AddNoteViewModel
class AddNoteViewModel: ObservableObject {
    // MARK: Repositories
    @Published var userRepository = UserRepository()
    @Published var noteRepository = NoteRepository()

    // MARK: Properties
    @Published var note: Note? /// `note` variable for edit mode
    @Published var content = ""
    @Published var destroyView = false
    @Published var error: Error?
    var isEditMode: Bool {
        note != nil
    }
    var isError: Bool {
        get { error?.localizedDescription != nil }
        set { error = nil }
    }
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init(_ note: Note? = nil) {
        self.note = note

        $note
            .compactMap { $0?.content }
            .assign(to: \.content, on: self)
            .store(in: &cancellables)
    }

    // MARK: Functions
    func addNote() {
        guard let userID = userRepository.currentUser?.id,
              !content.isEmpty else {
            return
        }

        if var updateNote = self.note {
            // Make sure the users change their notes
            guard updateNote.ownerId == userID else {
                return
            }

            // Update note
            updateNote.content = content
            updateNote.updatedAt = .now

            noteRepository.updateNote(updateNote)
                .sink { [weak self] completion in
                    switch completion {
                        case .finished:
                            self?.destroyView.toggle()
                        case .failure(let error):
                            self?.error = error
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)

        } else {
            // Add new note
            let newNote = Note(content: content,
                               ownerId: userID)

            noteRepository.addNote(newNote)
                .sink { [weak self] completion in
                    switch completion {
                        case .finished:
                            self?.destroyView.toggle()
                        case .failure(let error):
                            self?.error = error
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
        }
    }
}
