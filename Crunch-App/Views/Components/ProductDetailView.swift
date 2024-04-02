//
//  ProductDetailView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/13.
//

import SwiftUI
import UIKit
import RealmSwift


struct ProductDetailView: View {
    @StateObject var viewModel = ProductDetailViewModel(realmManager: RealmManager())

    let item: ProductModel

    var body: some View {
        VStack(alignment: .leading) {
            TabView {
                ForEach(item.gallery, id: \.self) { item in
                    Image(item)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
            .onAppear(perform: setupAppearance)
            Spacer()
            VStack(alignment: .leading) {
                HStack {
                    Text(item.name)
                        .font(.title.bold())
                        .padding(.bottom, 30)
                    Spacer()
                    HStack {
                        Spacer()
                        Text("R\(item.price)")
                            .font(.title.bold())
                            .foregroundStyle(Color.lightBlue)
                    }
                }
                Text("About:")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .padding(.bottom, 10)
                Text(item.description)
                    .foregroundStyle(Color.lightGray)
                    .padding(.bottom, 20)
                
                Button(action: {
                    viewModel.addItemToRealm(item: item)
                }, label: {
                    Text("Buy Now")
                        .font(.headline)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .fill(Color("LightBlue")))
                })
            }
        }
        .padding(.horizontal)
        .navigationTitle(item.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
//
//#Preview {
//    ProductDetailView(item: ProductModel(id: 1, name: "Acer Inspire", image: "laptops", description: "This is the best windows machine you could ever find This is the best windows machine you could ever find This is the best windows machine you could ever find This is the best windows machine you could ever find", price: 4500, gallery: ["acer-1", "acer-2", "acer-3"]))
//}
