//
//  ThuanVuNotesApp.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

@main
struct ThuanVuNotesApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                NoteListView()
            }
        }
    }
}
