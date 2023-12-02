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
        VStack(alignment: .leading) {
            Text(viewModel.title)
                .lineLimit(1)

            if !viewModel.isMySelf {
                Text("By: \(viewModel.username ?? "")")
                    .foregroundStyle(.gray)
                    .font(.footnote)
                    .italic()
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview {
    NoteListView()
}
