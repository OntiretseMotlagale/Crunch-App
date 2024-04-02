//
//  CartView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/18.
//

import SwiftUI
import RealmSwift


struct CartView: View {
    @StateObject var viewModel: CartViewModel
    init(realmManager: RealmManager) {
        _viewModel = StateObject(wrappedValue: CartViewModel(realmManager: realmManager))
    }
   
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            List {
                ForEach(viewModel.useableCartItems, id: \.self) { items in
                    CartItem(item: items)
                        .padding(.bottom, 10)
                }
                .onDelete(perform: viewModel.deleteItem)
            }
            .listStyle(.plain)
            .background(
                Color("SecondaryColor")
                    .ignoresSafeArea())
            HStack {
                Text("Total:")
                Spacer()
                Text("\(viewModel.total)")
            }
            .font(.title2)
            .fontWeight(.black)
            Button(action: {}, label: {
                Text("Checkout")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color("LightBlue")))
            })
        }
        .navigationTitle("My Cart")
        .navigationBarTitleDisplayMode(.inline)
        .padding(.horizontal)
        .padding(.bottom, 20)
    }
    
}

struct EmptyCartView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            Image("cart")
            Text("Your cart is empty")
                .font(.title)
                .fontWeight(.bold)
            Text("Looks like you haven't made your choise yet.")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .foregroundStyle(Color("LightGray"))
                .padding(.horizontal)
                .padding(.bottom, 30)
            Button(action: {}, label: {
                Text("Go Home")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color("LightBlue")))
            })
        }
        .padding(.horizontal)
    }
}

#Preview {
    CartView(realmManager: RealmManager())
}
