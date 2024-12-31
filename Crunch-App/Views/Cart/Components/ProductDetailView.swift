//
//  ProductDetailView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/13.
//

import SwiftUI
import UIKit
import RealmSwift
import AlertKit


struct ProductDetailView: View {
    @StateObject private var viewModel = ProductDetailViewModel(realmManager: RealmManager())
    let item: DatabaseProductItem
    @State private var showCartAlert: Bool = false

    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                TabView {
                    ForEach(item.gallery ?? [], id: \.self) { item in
                        Image(item)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 300)
                    }
                }
                .tabViewStyle(.page)
                .onAppear(perform: setupAppearance)
                Spacer()
                VStack(alignment: .leading) {
                    HStack(alignment: .center) {
                        Text(item.name!)
                            .font(.title2.bold())
                            .foregroundStyle(Color(AppColors.lightGray))
                        Spacer()
                        HStack {
                            Spacer()
                            Text("R\(item.price!)")
                                .font(.title3.bold())
                        }
                    }
                    Text("Description:")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding(.bottom, 10)
                        .padding(.top, 25)
                    Text(item.description!)
                        .foregroundStyle(Color.lightGray)
                        .padding(.bottom, 20)
                    CustomButton(title: "Add To Cart") {
                        viewModel.addItemToRealm(item: item)
                        withAnimation {
                            self.showCartAlert.toggle()
                        }
                    }
                }
            }
            .padding(.horizontal)
            .navigationTitle(item.name!)
            .navigationBarTitleDisplayMode(.inline)
        }
        .alert(isPresent: $showCartAlert, view: addedToCartAlert())
    }
    func addedToCartAlert() -> AlertAppleMusic16View {
        let alertView = AlertAppleMusic16View(title: "Added to Cart", icon: .done)
        alertView.duration = 2.0
        return alertView
    }
    
    func setupAppearance() {
        UIPageControl.appearance().currentPageIndicatorTintColor = .black
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.2)
    }
}
//
#Preview {
    ProductDetailView(
                      item: DatabaseProductItem(id: "",
                                                gallery: ["acer-1", "acer-2", "acer-3"],
                                                description: "This is the best windows machine you could ever find This is the best windows machine you could ever find This is the best windows machine you could ever find This is the best windows machine you could ever find",
                                                image: "laptops",
                                                name: "Acer Inspire",
                                                price: 4500))
}
