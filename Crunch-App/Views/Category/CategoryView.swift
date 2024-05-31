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
                Image(category.imageName)
                    .resizable()
                    .scaledToFit()
                    .padding()
                    .frame(width: 150, height: 150)
                    .background(Color(category.color), in: RoundedRectangle(cornerRadius: 10))
                    .padding()
                Spacer()
                Text(category.name)
                    .font(.custom(AppFonts.bold, size: 16))
                    .padding(.bottom, 4)
                    .foregroundStyle(.black)
                Text("\(category.productModel.count) Items")
                    .font(.custom(AppFonts.regular, size: 14))
                    .foregroundStyle(.black)
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 8)
                        .fill(Color.gray.opacity(0.1)))
                    .padding(.bottom, 20)
            }
            .frame(width: 170, height: 260)
            .background(.white, in: RoundedRectangle(cornerRadius: 10))
            .shadow(color: .black.opacity(0.1), radius: 4, x: 3, y: 3)
            .padding(.horizontal)
        }
    }
}

#Preview {
    CategoryView(category: CategoryModel(imageName: "macbook-1", color: "lightBlue", productModel: [], name: "Macbook Pro"))
}
