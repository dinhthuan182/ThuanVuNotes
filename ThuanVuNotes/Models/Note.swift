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
