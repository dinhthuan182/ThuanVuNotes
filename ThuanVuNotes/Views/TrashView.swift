//
//  TrashView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: TrashView
struct TrashView: View {
    // MARK: Properties
    @ObservedObject var viewModel = TrashViewModel()

    var body: some View {
        List(viewModel.noteRowViewModels) { noteViewModel in
            NoteRow(viewModel: noteViewModel)
        }
        .navigationTitle("Trash")
    }
}

#Preview {
    NavigationStack {
        TrashView()
    }
}
