//
//  AddNoteView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: AddNoteView
struct AddNoteView: View {
    // MARK: Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel = AddNoteViewModel()
    @FocusState private var editingNote: Bool

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TextEditor(text: $viewModel.content)
                            .padding(.horizontal)
                            .focused($editingNote)

            Button {
                editingNote = false
                viewModel.addNote()
            } label: {
                Image(systemName: viewModel.isEditMode ? "checkmark.circle" : "plus.circle")
                    .resizable()
                    .frame(width: 45, height: 45)
                    .padding([.bottom, .trailing], 10)
            }
            .disabled(viewModel.content.isEmpty)
        }
        .navigationTitle(viewModel.isEditMode ? "Update note" : "New note")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            editingNote = true
        }
        .onReceive(viewModel.$destroyView) { destroy in
            destroy ? dismiss() : nil
        }
        .alert(isPresented: $viewModel.isError) {
            Alert(title: Text("Error"),
                  message: Text(viewModel.error?.localizedDescription ?? ""))
        }
    }
}

#Preview {
    NavigationStack {
        AddNoteView()
    }
}
