//
//  TrashViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation

// MARK: TrashViewModel
class TrashViewModel: ObservableObject {
    // MARK: Properties
    @Published var noteRowViewModels = [NoteRowViewModel]()

    // MARK: Initialization
    init() {
        noteRowViewModels = []
    }
}
