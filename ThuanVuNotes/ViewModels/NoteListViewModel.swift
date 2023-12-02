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
    @Published var currentUsername: String = ""
    @Published var ownerOptions = NoteOwnerOption.allCases
    @Published var selectedOwnerOption: NoteOwnerOption = .mySelf
    @Published var searchNote: String = ""
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
            .assign(to: \.currentUsername, on: self)
            .store(in: &cancellables)
        userRepository.$currentUser
            .compactMap { $0?.id }
            .assign(to: \.currentUserId, on: self)
            .store(in: &cancellables)

        /// Reset search note when change `selectedOwnerOption`
        $selectedOwnerOption.sink { [weak self] _ in
            self?.searchNote = ""
        }
        .store(in: &cancellables)

        // Fetch notes with owner option
        Publishers.CombineLatest4(noteRepository.$availableNotes, $selectedOwnerOption, $searchNote, $currentUserId)
            .map { (notes, ownerOption, searchText, currentUserId) in
                var searchedNotes = notes
                /// Filter with `searchText`
                if !searchText.isEmpty {
                    searchedNotes = notes.filter { $0.content.containsWithLowercased(searchText) }
                }

                /// Filter with `ownerOption`
                /// And then maping to `NoteRowViewModel`(return type)
                switch ownerOption {
                    case .mySelf:
                        let mapingNotes = searchedNotes.filter { $0.ownerId == currentUserId }
                        return mapingNotes
                                .map { NoteRowViewModel(note: $0, viewMode: .mySelf) }

                    case .otherUsers:
                        let mapingNotes = searchedNotes.filter { $0.ownerId != currentUserId && $0.shared }
                        return mapingNotes
                                .map { NoteRowViewModel(note: $0, viewMode: .otherUser) }
                }
            }
            .assign(to: \.noteRowViewModels, on: self)
            .store(in: &cancellables)
    }

    func changeUserName() {
        userRepository.updateUsername(currentUsername)
            .sink { completion in
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }

    func revertUsername() {
        currentUsername = userRepository.currentUser?.username ?? ""
    }

    func deleteRow(_ rowViewModel: NoteRowViewModel) {
        // Make sure the users change their notes
        guard selectedOwnerOption == .mySelf,
              rowViewModel.note.ownerId == currentUserId else {
            return
        }

        noteRepository.deleteNote(rowViewModel.note)
            .sink { completion in
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }

    func changeShareState(_ rowViewModel: NoteRowViewModel) {
        var note = rowViewModel.note
        // Make sure the users change their notes
        guard selectedOwnerOption == .mySelf,
              note.ownerId == currentUserId else {
            return
        }

        note.shared.toggle()
        noteRepository.updateNote(note)
            .sink { completion in
            } receiveValue: { _ in }
            .store(in: &cancellables)
    }
}
