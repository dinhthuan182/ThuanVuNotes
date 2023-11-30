//
//  AppDelegate.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import Foundation
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // Config Firebase
        FirebaseApp.configure()
        Auth.auth().signInAnonymously()
        Database.database().isPersistenceEnabled = true

        return true
    }
}
