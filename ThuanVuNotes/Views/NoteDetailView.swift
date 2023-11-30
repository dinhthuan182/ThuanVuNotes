//
//  NoteDetailView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 30/11/2023.
//

import SwiftUI

// MARK: NoteDetailView
struct NoteDetailView: View {
    // MARK: Properties
    @ObservedObject var viewModel: NoteDetailViewModel

    var body: some View {
        VStack {
            UserView(viewModel: viewModel.userViewModel)
                .frame(height: 50)

            Divider()

            TextEditor(text: $viewModel.content)
                .foregroundStyle(.secondary)
                .padding(.horizontal)
                .disabled(true)
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(viewModel: NoteDetailViewModel(Note(title: "Test note",
                                                           content: "Test note content",
                                                           ownerId: "")))
    }
}
