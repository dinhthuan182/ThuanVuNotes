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
    // MARK: ViewMode
    enum ViewMode {
        case mySelf
        case otherUser
        case trash
    }

    // MARK: Repositories
    @Published var userRepository = UserRepository()

    // MARK: Properties
    @Published var note: Note
    @Published var shared: Bool = false
    @Published var title = ""
    @Published var username: String?
    @Published var viewMode: ViewMode
    var id = ""
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init(note: Note, viewMode: ViewMode) {
        self.note = note
        self.viewMode = viewMode

        $note
            .map { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        $note
            .map { $0.title }
            .assign(to: \.title, on: self)
            .store(in: &cancellables)
        $note
            .map { $0.shared }
            .assign(to: \.shared, on: self)
            .store(in: &cancellables)

        $note
            .filter { _ in self.viewMode == .otherUser }
            .flatMap { [weak self] note in
                self?.userRepository.getUser(note.ownerId) ?? Empty().eraseToAnyPublisher()
            }
            .sink { completion in
            } receiveValue: { [weak self] user in
                self?.username = user?.username
            }
            .store(in: &cancellables)
    }
}

// MARK: Hashable
extension NoteRowViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }

    static func == (lhs: NoteRowViewModel, rhs: NoteRowViewModel) -> Bool {
        lhs.id == rhs.id
    }
}
