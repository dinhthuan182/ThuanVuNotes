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
    @Published var userViewModel: UserViewModel
    @Published var noteRowViewModels = [NoteRowViewModel]()
    // Properties
    @Published var choices = NoteType.allCases
    @Published var choice: NoteType = .mySelf
    @Published var notes: [Note] = testDataNotes
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init() {
        userViewModel = UserViewModel(user: User())
        noteRowViewModels = testDataNotes.map { note in
            NoteRowViewModel(note: note)
        }
    }
}
