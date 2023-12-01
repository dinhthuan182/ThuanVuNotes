//
//  Note.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation

// MARK: Note
struct Note: Codable, Identifiable {
    var id: String = UUID().uuidString
    var content: String
    var ownerId: String
    var createdAt: Date? = .now
    var updatedAt: Date? = .now
    var deletedAt: Date?
}

extension Note {
    var title: String {
        content.getFirstLine() ?? content
    }
}
