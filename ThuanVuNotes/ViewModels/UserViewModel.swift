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
    @Published var user: User
    @Published var userName: String?
    private var cancellables = Set<AnyCancellable>()

    // MARK: Initialization
    init(user: User) {
        self.user = user

        $user
            .map { $0.username }
            .assign(to: \.userName, on: self)
            .store(in: &cancellables)
    }
}
