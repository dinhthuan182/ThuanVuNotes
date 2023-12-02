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
    var onTapShare: ((NoteRowViewModel) -> Void)?

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(viewModel.title)
                    .lineLimit(1)

                if viewModel.viewMode == .otherUser {
                    Text("By: \(viewModel.username ?? "")")
                        .foregroundStyle(.gray)
                        .font(.footnote)
                        .italic()
                }
            }

            Spacer()

            if viewModel.viewMode == .mySelf {
                Image(systemName: viewModel.shared ? "person.2.fill" : "person.2.slash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25)
                    .foregroundStyle(viewModel.shared ? .blue : .gray)
                    .onTapGesture {
                        onTapShare?(viewModel)
                    }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .contentShape(Rectangle())
    }
}

#Preview {
    NoteListView()
}
