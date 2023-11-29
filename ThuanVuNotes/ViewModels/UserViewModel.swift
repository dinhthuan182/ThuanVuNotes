//
//  UserViewModel.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Combine

// MARK: UserViewModel
class UserViewModel: ObservableObject {
    // MARK: Properties
    @Published var username: String?
}
