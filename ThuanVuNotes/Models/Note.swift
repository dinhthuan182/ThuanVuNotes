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

#if DEBUG
let testDataNotes = [
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", ownerId: ""),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", ownerId: ""),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", ownerId: ""),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", ownerId: ""),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ownerId: "eee"),
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", ownerId: "aaaa"),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", ownerId: ""),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", ownerId: "aaaa"),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", ownerId: ""),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ownerId: "eee"),
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", ownerId: "aaaa"),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", ownerId: ""),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", ownerId: "aaaa"),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", ownerId: ""),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", ownerId: "eee"),
]
#endif
