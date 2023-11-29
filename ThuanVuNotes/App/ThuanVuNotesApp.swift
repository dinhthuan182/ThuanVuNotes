//
//  ThuanVuNotesApp.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

@main
struct ThuanVuNotesApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NoteListView()
            }
        }
    }
}
