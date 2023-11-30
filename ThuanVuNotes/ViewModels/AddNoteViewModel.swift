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
    @Published var content = ""
    @Published var destroyView = false
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()

    // MARK: Functions
    func addNote() {
        guard let userID = userRepository.currentUser?.id else {
            return
        }

        // Get the first line of content to make the note's title
        let title = content.getFirstLine() ?? content
        let note = Note(title: title,
                        content: content,
                        ownerId: userID)

        noteRepository.addNote(note)
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
