//
//  NoteRow.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: NoteRow
struct NoteRow: View {
    // MARK: Properties
    @ObservedObject var viewModel: NoteRowViewModel

    var body: some View {
        VStack {
            Text(viewModel.title)

            if let username = viewModel.username {
                Text("By: " + username)
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .italic()
            }
        }
    }
}

#Preview {
    NoteListView()
}
