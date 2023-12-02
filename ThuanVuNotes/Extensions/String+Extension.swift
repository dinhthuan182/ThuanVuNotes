//
//  String+Extension.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 30/11/2023.
//

import Foundation

extension String {
    func getFirstLine() -> String? {
        self.components(separatedBy: .newlines).first
    }

    func containsWithLowercased<T>(_ other: T) -> Bool where T : StringProtocol {
        self.lowercased().contains(other.lowercased())
    }
}
