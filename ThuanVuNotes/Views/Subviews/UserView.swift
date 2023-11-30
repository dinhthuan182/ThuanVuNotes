//
//  UserView.swift
//  ThuanVuNotes
//
//  Created by Thuận Vũ on 29/11/2023.
//

import SwiftUI

// MARK: UserView
struct UserView: View {
    // MARK: Properties
    @ObservedObject var viewModel: UserViewModel
    var reverceLayout = false

    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)

            if let username = viewModel.username,
               !username.isEmpty {
                Text(username)
            }
        }
        .environment(\.layoutDirection, reverceLayout ? .rightToLeft: .leftToRight)
    }
}

