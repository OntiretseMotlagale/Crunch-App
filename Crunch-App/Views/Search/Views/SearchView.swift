//
//  FavouriteView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/11.
//

import SwiftUI

struct FavouriteView: View {
    @State var searchText: String = ""
    var body: some View {
        NavigationStack {
            VStack {
            Text(searchText)
            }
            .searchable(text: $searchText, prompt: "Search for item")
          
        }
        .background(
           Color(AppColors.primaryLightGray)
            .ignoresSafeArea())
    }
}

#Preview {
    FavouriteView()
}
