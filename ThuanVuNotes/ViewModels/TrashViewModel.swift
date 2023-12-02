//
//  TrashViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Combine

// MARK: TrashViewModel
class TrashViewModel: ObservableObject {
    // MARK: Repositories
    @Published var userRepository = UserRepository()
    @Published var noteRepository = NoteRepository()

    // MARK: Properties
    @Published var noteRowViewModels = [NoteRowViewModel]()
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        noteRepository.$mineDeletedNotes
            .map { notes in
                notes.map { NoteRowViewModel(note: $0, viewMode: .trash) }
            }
            .assign(to: \.noteRowViewModels, on: self)
            .store(in: &cancellables)
    }

    func recoverRow(_ rowViewModel: NoteRowViewModel) {
        noteRepository.recoverNote(rowViewModel.note)
            .sink { completion in
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
