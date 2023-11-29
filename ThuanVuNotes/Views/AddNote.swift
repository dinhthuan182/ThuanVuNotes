//
//  AddNote.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: AddNote
struct AddNote: View {
    // MARK: Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AddNoteViewModel()
    @FocusState private var editingNote: Bool

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextEditor(text: $viewModel.content)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal)
                            .focused($editingNote)

            Button {
                dismiss()
            } label: {
                Image(systemName: "plus.circle")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding([.bottom, .trailing], 10)
            }
        }
        .navigationTitle("New note")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            editingNote.toggle()
        }
    }
}
