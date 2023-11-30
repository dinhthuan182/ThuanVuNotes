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
}
