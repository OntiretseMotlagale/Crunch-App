//
//  HomeVIew.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/09.
//

import SwiftUI
import RealmSwift

struct HomeView: View {
    
    @StateObject private var viewModel = HomeViewModel()
    @ObservedResults(RealmDatabaseUser.self) var databaseUser
    let column: [GridItem] = [
        GridItem(.flexible(), spacing: 15, alignment: nil),
        GridItem(.flexible(), spacing: 15, alignment: nil)]
   
    var body: some View {
        NavigationStack {
            ScrollView  {
                VStack {
                    if let name = databaseUser.first {
                        Text("Welcome back, \n\(viewModel.getFirstWord(word: name.fullname))!")
                            .font(.custom(AppFonts.regular, size: 26))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 30)
                            .padding(.bottom, 20)
                    }
                    LazyVGrid(columns: column,
                              alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                              spacing: 20,
                              content: {
                        ForEach(viewModel.getJsonData()) { item in
                            NavigationLink {
                                CategoryItemView(item: item.productModel)
                            } label: {
                                CategoryView(category: item)
                            }
                        }
                    })
                }
                .padding(.horizontal)
                .navigationTitle("Home")
                .navigationBarTitleDisplayMode(.inline)
            }
            .background(
                Color(AppColors.primaryLightGray)
                    .ignoresSafeArea())
        }
        .task {
            try? await viewModel.setupProductItems()
        }
    }
}
#Preview {
    HomeView()
}


