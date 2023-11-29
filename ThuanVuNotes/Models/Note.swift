//
//  Note.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation

// MARK: Note
struct Note: Identifiable {
    var id: String = UUID().uuidString
    var title: String
    var content: String
    var owner: User
}

// MARK: Hashable
extension Note: Hashable {
    static func == (lhs: Note, rhs: Note) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.content == rhs.content &&
        lhs.owner == rhs.owner
    }
}

#if DEBUG
let testDataNotes = [
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", owner: User(username: "aaaa")),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", owner: User()),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", owner: User(username: "aaaa")),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", owner: User()),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", owner: User(username: "eee")),
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", owner: User(username: "aaaa")),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", owner: User()),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", owner: User(username: "aaaa")),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", owner: User()),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", owner: User(username: "eee")),
    Note(title: "Aaaaaaa", content: "AaaaaaaaaaaAaaaaaaaaaaAaaaaaaaaaa", owner: User(username: "aaaa")),
    Note(title: "Bbbbbbb", content: "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb", owner: User()),
    Note(title: "Ccccccc", content: "cccccccccccccccccccccccccccccccc", owner: User(username: "aaaa")),
    Note(title: "Ddddddd", content: "dddddddddddddddddddddddddddddddddddd", owner: User()),
    Note(title: "Eeeeeee", content: "eeeeeeeeeeeeeeeeeeeeeeeeeeeeee", owner: User(username: "eee")),
]
#endif
