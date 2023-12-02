//
//  NoteListView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI
import Combine

// MARK: NoteListView
struct NoteListView: View {
    // MARK: SubView
    enum SubView {
        case addNote
        case trash
    }
    
    // MARK: Properties
    @ObservedObject var viewModel = NoteListViewModel()
    @State private var changeUsername = false
    @State private var displaySubView: SubView? = nil

    var body: some View {
        List(viewModel.noteRowViewModels) { rowViewModel in
            Button {
                viewModel.selectedNoteRowViewModel = rowViewModel
            } label: {
                NoteRow(viewModel: rowViewModel)
                    .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                        Button("Delete", role: .destructive) {
                            viewModel.deleteRow(rowViewModel)
                        }
                    }
                    .disabled(viewModel.selectedOwnerOption != .mySelf)
            }
            .buttonStyle(.plain)
        }
        .listStyle(.insetGrouped)
        .safeAreaInset(edge: .bottom) {
            HStack(spacing: 20) {
                Button {
                    displaySubView = .trash
                } label: {
                    Image(systemName: "trash.circle")
                        .resizable()
                        .frame(width: 35, height: 35)
                        .padding(.leading)
                }

                Picker("Owner option", selection: $viewModel.selectedOwnerOption) {
                    ForEach(viewModel.ownerOptions, id: \.self) { option in
                        Text(option.title)
                            .tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Button {
                    displaySubView = .addNote
                } label: {
                    Image(systemName: "square.and.pencil.circle")
                        .resizable()
                        .frame(width: 45, height: 45)
                        .padding(.trailing, 10)
                }
            }
            .padding(.bottom)
        }
        .navigationTitle("Notes")
        .toolbar {
            Button {
                changeUsername.toggle()
            } label: {
                UserView(viewModel: viewModel.userViewModel,
                         reverceLayout: true)
                .frame(height: 30)
            }
        }
        // Navigation link for select item in list
        .navigationDestination(item: $viewModel.selectedNoteRowViewModel) { rowViewModel in
            switch viewModel.selectedOwnerOption {
                case .mySelf:
                    // Update note
                    AddNoteView(viewModel: AddNoteViewModel(rowViewModel.note))
                case .otherUsers:
                    // View note detail of other users
                    NoteDetailView(viewModel: NoteDetailViewModel(rowViewModel.note))
            }
        }
        // Navigation link for buttons
        .navigationDestination(item: $displaySubView) { subview in
            switch subview {
                case .addNote:
                    AddNoteView()
                case .trash:
                    TrashView()
            }
        }
        .alert("Tell other people your name", isPresented: $changeUsername) {
            TextField("Enter your name here", text: $viewModel.currentUsername)
                .onSubmit(changeUserName)

            Button("Change", action: changeUserName)

            Button("Cancel", role: .cancel) {
                viewModel.revertUsername()
            }
        }
    }

    private func changeUserName() {
        viewModel.changeUserName()
        changeUsername.toggle()
    }
}

#Preview {
    NavigationStack {
        NoteListView()
    }
}
