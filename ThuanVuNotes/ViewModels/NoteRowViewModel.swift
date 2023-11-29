//
//  NoteRowViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Combine

// MARK: NoteRowViewModel
class NoteRowViewModel: ObservableObject, Identifiable {
    // MARK: Repositories
//    @Published var userRepository = UserRepository()

    // MARK: Properties
    @Published var note: Note
    @Published var title = ""
    @Published var username: String?
    var id = ""
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init(note: Note) {
        self.note = note

        $note
            .map { $0.title }
            .assign(to: \.title, on: self)
            .store(in: &cancellables)

//        $note
//            .map { $0.owner.username }
//            .assign(to: \.username, on: self)
//            .store(in: &cancellables)

        $note
            .map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
}
