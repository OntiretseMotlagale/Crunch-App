//
//  OrderItem.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/07/27.
//

import Foundation
import SwiftUI


struct OrderItem: View {
    let item: DatabaseUserOrder
    var body: some View {
            HStack (alignment: .center) {
                if let image = item.productImage {
                    Image(image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 0.3)
                }
                VStack(alignment: .leading, spacing: 20) {
                    if let name = item.productname {
                        Text(name)
                            .font(.custom(AppFonts.semibold, size: 18))
                    }
                    HStack (alignment: .center) {
                        Text("Price:")
                            .font(.custom(AppFonts.regular, size: 14))
                            .foregroundStyle(.black.opacity(0.6))
                        if let price = item.price {
                            Text("R\(price)")
                                .font(.custom(AppFonts.semibold, size: 15))
                        }
                        Spacer()
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .frame(height: 120)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(.white))
            .cornerRadius(10)
            .navigationTitle("My Order")
            .navigationBarTitleDisplayMode(.inline)


    }
}

#Preview {
    OrderItem(item: DatabaseUserOrder(id: "2332", uid: "", productImage: "airpods-1", productname: "Airpods Pro", price: 6000, date: .now))
}
