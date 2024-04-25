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
            if viewModel.useableCartItems.isEmpty {
                Spacer()
                EmptyCartView()
                Spacer()
            }
            else {
                  List {
                        ForEach(viewModel.useableCartItems, id: \.self) { items in
                            CartItem(item: items)
                                .padding(.bottom, 10)
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                    .listStyle(.plain)
                    Spacer()
                    VStack {
                        Group {
                            Divider()
                            CheckoutMenu(text: .constant("Subtotal: "), value: .constant("R500.00"))
                            CheckoutMenu(text: .constant("Shipping:"), value: .constant("R500.00"))
                            Divider()
                            CheckoutMenu(text: .constant("Total:"), value: .constant("R1000.00"))
                        }
                        .padding(.bottom, 10)
                        
                        Button(action: {}, label: {
                            Text("Checkout")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .frame(height: 55)
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 20)
                                    .fill(Color("primaryPurple")))
                        })
                    }
            }
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
        }
        .padding(.horizontal)
    }
}

#Preview {
    CartView(realmManager: RealmManager())
}

struct CheckoutMenu: View {
    @Binding var text: String
    @Binding var value: String
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(Color("LightGray"))
                .font(.system(size: 16))
            Spacer()
            Text(value)
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }
}
