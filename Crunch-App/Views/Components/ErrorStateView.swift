//
//  ErrorStateView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/26.
//

import SwiftUI

enum ErrorState: Error {
    
}
struct ErrorStateView: View {
    @Binding var error: String
    var body: some View {
        HStack {
            Image(systemName: "info.circle")
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
               Text(error)
        }
        .foregroundStyle(.red)
    }
}

#Preview {
    ErrorStateView(error: .constant("Wrong password try again."))
}
