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
    @State private var paymentView: Bool = false
    @State private var realmItems: UsableCartItems = UsableCartItems(name: "", image: "", price: 0, descript: "")
    
    var body: some View {
        NavigationStack {
            VStack (alignment: .leading, spacing: 20) {
                if viewModel.useableCartItems.isEmpty {
                    Spacer()
                    EmptyCartView()
                    Spacer()
                }
                else {
                    List {
                        ForEach(viewModel.useableCartItems, id: \.self) { items in
                            
                            CartItem(cartViewModel: viewModel,
                                     item: items)
                            
                            .padding(.bottom, 10)
                        }
                        .onDelete(perform: viewModel.deleteItem)
                    }
                    .listStyle(.plain)
                    .scrollIndicators(.hidden)
                    .buttonStyle(.plain)
                    Spacer()
                    VStack {
                        Group {
                            Divider()
                            CheckoutMenu(text: "Total:", value: $viewModel.total)
                        }
                        .padding(.bottom, 10)
                        
                        CustomButton(title: "Checkout") {
                            self.paymentView = true
                            Task {
                                try await viewModel.submitOrder()
                            }
                            
                        }
                    }
                    .padding(.horizontal)
                    
                }
            }
            .fullScreenCover(isPresented: $paymentView, content: {
                ProcessPaymentView()
            })
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.bottom, 20)
            .background(
                Color(AppColors.primaryLightGray)
                    .ignoresSafeArea())
        }
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
    //    ProcessPaymentView()
}
struct ProcessPaymentView: View {
    @State private var show: Bool = false
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryLightGray
                VStack(spacing: 30) {
                    ProgressView()
                        .controlSize(.extraLarge)
                    Text("Loading...")
                        .font(.custom(AppFonts.semibold, size: 26))
                    Text("Processing your payment... Please wait as we handle your transaction.")
                        .font(.custom(AppFonts.regular, size: 22))
                        .multilineTextAlignment(.center)
                }
                .padding(.horizontal)
                .fullScreenCover(isPresented: $show, content: {
                    SuccessState(viewModel: CartViewModel(realmManager: RealmManager()), show: $show)
                })
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        self.show = true
                    }
                }.navigationBarBackButtonHidden()
            }
        }
        .background(
            Color.green)
    }
}
struct CheckoutMenu: View {
    var text: String
    @Binding var value: Int
    var body: some View {
        HStack {
            Text(text)
                .foregroundStyle(Color("LightGray"))
                .font(.system(size: 16))
            Spacer()
            Text("R\(value)")
                .font(.system(size: 20))
                .fontWeight(.bold)
        }
    }
}
