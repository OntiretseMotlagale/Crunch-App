//
//  CartItem.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/18.
//

import SwiftUI

struct CartItem: View {
    let item: UsableCartItems
    var body: some View {
            HStack (alignment: .center) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color("PrimaryGray")))
                VStack(alignment: .leading, spacing: 20) {
                    Text(item.name)
                        .font(.title3)
                        .fontWeight(.thin)
                    HStack (alignment: .center) {
                        Text("Price:")
                            .font(.footnote)
                        Text("R\(item.price)")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                        Spacer()
                        HStack(alignment: .center) {
                            QuantityButton(imageName: "minus") {
                                
                            }
                            Text("1")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            QuantityButton(imageName: "plus") {
                                
                            }
                        }
                        .padding(.trailing, 2)
                    }
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(.white))
            .cornerRadius(10)
            .padding(.horizontal)
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    struct QuantityButton: View {
        let imageName: String
        var buttonAction: () -> ()
        var body: some View {
            Button(action: {
                buttonAction()
            }, label: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8)
                    .foregroundColor(.black)
                    .padding(8)
                    .frame(width: 25, height: 25)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .fill(Color("PrimaryGray")))
            })
        }
    }
}

#Preview {
    CartItem(item: UsableCartItems(name: "Acer Laptop", image: "acer-1", price: 13999, descript: "fhkhf foinfif"))
}
