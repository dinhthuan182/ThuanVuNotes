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
    // MARK: NoteOwnerOption
    enum NoteOwnerOption: CaseIterable {
        case mySelf
        case otherUsers

        var title: String {
            switch self {
                case .mySelf:
                    "My self"
                case .otherUsers:
                    "Other users"
            }
        }
    }

    // MARK: Repositories
    @Published var userRepository = UserRepository()
    @Published var noteRepository = NoteRepository()

    // MARK: Properties
    // Subview view models
    @Published var userViewModel = UserViewModel()
    @Published var noteRowViewModels = [NoteRowViewModel]()
    @Published var selectedNoteRowViewModel: NoteRowViewModel?
    // Properties
    @Published var currentUserId: String = ""
    @Published var username: String = ""
    @Published var ownerOptions = NoteOwnerOption.allCases
    @Published var selectedOwnerOption: NoteOwnerOption = .mySelf
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        // Fetch current user information
        userRepository.$currentUser
            .map { $0?.username }
            .assign(to: \.userViewModel.username, on: self)
            .store(in: &cancellables)
        userRepository.$currentUser
            .compactMap { $0?.username }
            .assign(to: \.username, on: self)
            .store(in: &cancellables)
        userRepository.$currentUser
            .compactMap { $0?.id }
            .assign(to: \.currentUserId, on: self)
            .store(in: &cancellables)

        // Fetch notes with owner option
        Publishers.CombineLatest3(noteRepository.$availableNotes, $selectedOwnerOption, $currentUserId)
            .map { (notes, ownerOption, currentUserId) in
                switch ownerOption {
                    case .mySelf:
                        let mapingNotes = notes.filter { $0.ownerId == currentUserId }
                        return mapingNotes.map { NoteRowViewModel(note: $0, isMySelf: true) }

                    case .otherUsers:
                        let mapingNotes = notes.filter { $0.ownerId != currentUserId }
                        return mapingNotes.map { NoteRowViewModel(note: $0, isMySelf: false) }
                }
            }
            .assign(to: \.noteRowViewModels, on: self)
            .store(in: &cancellables)
    }

    func changeUserName() {
        userRepository.updateUsername(username)
            .sink { completion in

            } receiveValue: { _ in }
            .store(in: &cancellables)
    }

    func revertUsername() {
        username = userRepository.currentUser?.username ?? ""
    }

    func deleteRow(_ rowViewModel: NoteRowViewModel) {
        noteRepository.deleteNote(rowViewModel.note)
            .sink { completion in
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
