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
    var title: String
    var content: String
    var ownerId: String
    var createdAt: Date?
    var updatedAt: Date?
    var deletedAt: Date?
}

// MARK: Hashable
extension Note: Hashable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.content == rhs.content &&
        lhs.ownerId == rhs.ownerId
    }
}
