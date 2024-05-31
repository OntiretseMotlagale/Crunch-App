//
//  HomeVIew.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/09.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    let column: [GridItem] = [
        GridItem(.flexible(), spacing: 15, alignment: nil),
        GridItem(.flexible(), spacing: 15, alignment: nil)]
    
    init() {
        for familyName in UIFont.familyNames {
           print(familyName)
            
            for fontName in UIFont.fontNames(forFamilyName: familyName) {
                print("---\(fontName)")
            }
        }
    }
    var body: some View {
        NavigationStack {
            ScrollView  {
                VStack {
                    LazyVGrid(columns: column,
                              alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,
                              spacing: 20,
                              content: {
                        ForEach(viewModel.getData()) { item in
                            NavigationLink {
                                CategoryItemView(item: item.productModel)
                            } label: {
                                CategoryView(category: item)
                            }
                        }
                    })
                }
                .padding(.horizontal)
            }
            .background(
                Color(AppColors.primaryLightGray)
                    .ignoresSafeArea())
        }
    }
}
#Preview {
    HomeView()
}


