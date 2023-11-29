//
//  NoteListViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI
import Combine

// MARK: NoteListViewModel
class NoteListViewModel: ObservableObject {
    // MARK: Repositories
    @Published var userRepository = UserRepository()
    @Published var noteRepository = NoteRepository()

    // MARK: NoteType
    enum NoteType: CaseIterable {
        case mySelf
        case OtherUsers

        var title: String {
            switch self {
                case .mySelf:
                    "Your notes"
                case .OtherUsers:
                    "Other users"
            }
        }
    }

    // MARK: Properties
    // Subview view models
    @Published var userViewModel = UserViewModel()
    @Published var noteRowViewModels = [NoteRowViewModel]()
    // Properties
    @Published var username: String = ""
    @Published var choices = NoteType.allCases
    @Published var choice: NoteType = .mySelf
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        // Fetch current username
        userRepository.$currentUser
            .map { $0?.username }
            .assign(to: \.userViewModel.username, on: self)
            .store(in: &cancellables)
        userRepository.$currentUser
            .map { $0?.username ?? "" }
            .assign(to: \.username, on: self)
            .store(in: &cancellables)

        // Fetch notes
        noteRepository.$notes
            .flatMap { $0.publisher }
            .map { note in
                NoteRowViewModel(note: note)
            }
            .collect()
            .assign(to: \.noteRowViewModels, on: self)
            .store(in: &cancellables)
    }

    func changeUserName() {
        userRepository.updateUsername(username)
    }

    func revertUsername() {
        username = userRepository.currentUser?.username ?? ""
    }
}
