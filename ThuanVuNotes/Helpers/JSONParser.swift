//
//  JSONParser.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 30/11/2023.
//

import Foundation
import Combine

// MARK: JSONParser
class JSONParser {
    func decode<T: Decodable>(_ anyData: Any) throws -> T {
        do {
            let data = try JSONSerialization.data(withJSONObject: anyData)
            let decoder = JSONDecoder()

            return try decoder.decode(T.self, from: data)
        } catch {
            throw error
        }
    }

    func encode<T: Encodable>(_ data: T) throws -> Any {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(data)

            return try JSONSerialization.jsonObject(with: data)
        } catch {
            throw error
        }
    }
}
