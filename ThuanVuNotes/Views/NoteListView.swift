//
//  NoteListView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: NoteListView
struct NoteListView: View {
    // MARK: SubView
    enum SubView {
        case addNote
        case trash
    }
    
    // MARK: Properties
    @ObservedObject var viewModel = NoteListViewModel()
    @State var displaySubView: SubView? = nil

    var body: some View {
        List(viewModel.noteRowViewModels) { noteViewModel in
            NoteRow(viewModel: noteViewModel)
        }
        .listStyle(.inset)
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

                Picker("Type", selection: $viewModel.choice) {
                    ForEach(viewModel.choices, id: \.self) { option in
                        Text(option.title)
                            .tag(option)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Button {
                    displaySubView = .addNote
                } label: {
                    Image(systemName: "pencil.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.trailing, 10)
                }
            }
        }
        .navigationDestination(item: $displaySubView) { subview in
            switch subview {
                case .addNote:
                    AddNote()
                case .trash:
                    TrashView()
            }
        }
        .navigationTitle("Notes")
        .toolbar {
            Button {

            } label: {
                UserView(viewModel: viewModel.userViewModel,
                         reverceLayout: true)
            }
        }
    }
}

#Preview {
    NavigationStack {
        NoteListView()
    }
}
