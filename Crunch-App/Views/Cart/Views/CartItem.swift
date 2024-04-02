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
                    .background(RoundedRectangle(cornerRadius: 20)
                        .fill(Color("SecondaryColor")))
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
                            Button(action: {}, label: {
                                Image(systemName: "minus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 8)
                                    .foregroundColor(.black)
                                    .padding(8)
                                    .frame(width: 25, height: 25)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color("SecondaryColor")))
                            })
                            Text("1")
                                .font(.caption)
                                .fontWeight(.bold)
                            Button(action: {}, label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 8)
                                    .foregroundColor(.white)
                                    .padding(8)
                                    .frame(width: 25, height: 25)
                                    .background(RoundedRectangle(cornerRadius: 5)
                                        .fill(Color("LightBlue")))
                            })
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
}
//
//#Preview {
//    CartItem(item: RealmProductItem())
//}
