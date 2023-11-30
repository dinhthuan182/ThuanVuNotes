//
//  NoteDetailViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 30/11/2023.
//

import Foundation
import Combine

// MARK: NoteDetailViewModel
class NoteDetailViewModel: ObservableObject {
    // MARK: Repositories
    @Published var userRepository = UserRepository()

    // MARK: Properties
    // Subview view models
    @Published var userViewModel = UserViewModel()
    @Published var note: Note
    @Published var content = ""
    private var cancellables = Set<AnyCancellable>()

    init(_ note: Note) {
        self.note = note

        $note
            .map { $0.content }
            .assign(to: \.content, on: self)
            .store(in: &cancellables)

        userRepository.getUser(note.ownerId)
            .sink { completion in
            } receiveValue: { [weak self] user in
                self?.userViewModel.username = user?.username
            }
            .store(in: &cancellables)
    }
}
