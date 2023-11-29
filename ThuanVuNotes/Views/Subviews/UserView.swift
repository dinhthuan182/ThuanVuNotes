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
                .frame(width: 40, height: 40)

            if let username = viewModel.userName {
                Text(username)
            }
        }
        .environment(\.layoutDirection, reverceLayout ? .rightToLeft: .leftToRight)
    }
}

