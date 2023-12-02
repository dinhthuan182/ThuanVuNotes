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
        List(viewModel.noteRowViewModels) { rowViewModel in
            NoteRow(viewModel: rowViewModel)
                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                    Button("Recover", role: .destructive) {
                        viewModel.recoverRow(rowViewModel)
                    }
                    .tint(.blue)
                }
        }
        .listStyle(.insetGrouped)
        .navigationTitle("Trash")
    }
}

#Preview {
    NavigationStack {
        TrashView()
    }
}
