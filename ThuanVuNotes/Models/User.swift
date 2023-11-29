//
//  User.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation

// MARK: User
struct User: Codable, Identifiable {
    var id: String
    var username: String? = nil
}

// MARK: Hashable
extension User: Hashable {
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.id == rhs.id &&
        lhs.username == rhs.username
    }
}
