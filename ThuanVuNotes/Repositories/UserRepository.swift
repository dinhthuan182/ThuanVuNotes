//
//  UserRepository.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Firebase
import Combine

// MARK: NoteRepository
class UserRepository: ObservableObject {
    // MARK: Properties
    var reference: DatabaseReference {
        Database.database().reference().child("users")
    }
    @Published var currentUser: User?

    // MARK: Initialization
    init() {
        fetchCurrentUser()
    }

    // MARK: Functions
    func fetchCurrentUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            // Fatal error
            return
        }

        reference.child(userId).observeSingleEvent(of: .value) { data in
            let value = data.value as? NSDictionary
            print(">>> currentUser:", value)
        }
    }

    func getUser(_ userId: String) { //-> AnyPublisher<User, Error> {
        reference.child(userId).getData { error, data in
            guard let data = data else {
                return
            }

            let value = data.value as? NSDictionary
            print(">>> getUser:", value)

        }
    }

    func updateUsername(_ username: String?) {
        guard let userId = currentUser?.id else {
            // Fatal error
            return
        }

        reference.child(userId).setValue(["username": username])
    }
}

