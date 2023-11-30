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
        guard let userId = Auth.auth().currentUser?.uid else { return }

        reference.child(userId)
            .observe(.value) { [weak self] snapshot in
                guard let value = snapshot.value, !(value is NSNull) else {
                    self?.currentUser = User(id: userId)

                    return
                }

                do {
                    self?.currentUser = try JSONParser().decode(value)
                } catch {
                    self?.currentUser = User(id: userId)
                }
            }
    }

    func getUser(_ userId: String) -> AnyPublisher<User, Error> {
        return Future<User, Error> { [weak self] promise in
            guard let self = self else { return }

            reference.child(userId)
                .getData { error, snapshot in
                    if let snapshot = snapshot {
                        do {
                            let user: User = try JSONParser().decode(snapshot.value as Any)
                            promise(.success(user))
                        } catch {
                            promise(.failure(error))
                        }
                    } else if let error = error {
                        promise(.failure(error))
                    }
                }
        }
        .eraseToAnyPublisher()
    }

    func updateUsername(_ username: String?) -> AnyPublisher<Any, Error> {
        return Just(currentUser)
            .compactMap { currentUser -> (String, User)? in
                guard let userId = currentUser?.id else {
                    return nil
                }

                return (userId, User(id: userId, username: username))
            }
            .tryMap { userId, updatedUser in
                (userId, try JSONParser().encode(updatedUser))
            }
            .compactMap { [weak self] id, dictionary in
                self?.reference.child(id).setValue(dictionary)
            }
            .eraseToAnyPublisher()
    }
}

