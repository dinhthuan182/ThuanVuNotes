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

        reference.child(userId)
            .observe(.value) { [weak self] data in
                let value = data.value as? NSDictionary
                let username = value?["username"] as? String
                self?.currentUser = User(id: userId, username: username)
            }
    }

    func getUser(_ userId: String) -> AnyPublisher<User, Error> {
        return Future<User, Error> { [weak self] promise in
            guard let self = self else { return }

            reference.child(userId)
                .getData { error, data in
                    if let data = data {
                        let value = data.value as? NSDictionary
                        let username = value?["username"] as? String
                        let user = User(id: userId, username: username)
                        promise(.success(user))
                    } else if let error = error {
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    func updateUsername(_ username: String?) {
        guard let userId = currentUser?.id else {
            // Fatal error
            return
        }

        reference.child(userId).setValue(["username": username])
    }
}

