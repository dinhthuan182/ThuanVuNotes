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
