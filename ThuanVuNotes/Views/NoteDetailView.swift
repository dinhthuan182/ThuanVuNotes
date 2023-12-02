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
        VStack(alignment: .leading) {
            UserView(viewModel: viewModel.userViewModel)
                .frame(height: 35)
                .padding(.leading)

            Divider()

            ScrollView {
                Text(viewModel.content)
                    .textSelection(.enabled)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }

            Spacer()
        }
        .navigationTitle("Detail")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NoteDetailView(viewModel: NoteDetailViewModel(Note(content: "Test note content",
                                                           ownerId: "")))
    }
}
