//
//  CategoryView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/11.
//

import SwiftUI

struct CategoryView: View {
    let category: CategoryModel
    var body: some View {
        VStack {
            VStack {
                VStack {
                    Image(category.imageName)
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
                .frame(width: 150, height: 150)
                .background(Color(category.color), in: RoundedRectangle(cornerRadius: 10))
                .padding()
                Spacer()
                Text(category.name)
                    .font(.headline)
                    .padding(.bottom, 4)
                    .foregroundStyle(.black)
                Text("\(category.productModel.count) Items")
                    .font(.footnote)
                    .foregroundStyle(.black)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.2)))
                    .padding(.bottom, 20)
            }
            .frame(width: 170, height: 260)
            .background(.white, in: RoundedRectangle(cornerRadius: 10))
        .padding(.horizontal)
        }
        .shadow(color: .black.opacity(0.4), radius: 6, x: 0.5, y: 0.5)
        
    }
}

#Preview {
    CategoryView(category: CategoryModel(imageName: "macbook-1", color: "lightBlue", productModel: [], name: "Macbook Pro"))
}
