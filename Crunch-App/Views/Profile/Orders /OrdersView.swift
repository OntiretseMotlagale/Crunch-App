//
//  OrdersView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI
import FirebaseAuth
import RealmSwift

@MainActor
class OrdersViewModel: ObservableObject {
    @Published private(set)var user: DatabaseUser?
    @Inject var userViewModel: UserProvider
    
    func fetchOrders() async throws {
        guard let authUser = Auth.auth().currentUser?.uid else {
            return
        }
        do {
            self.user = try await userViewModel.getUser(userID: authUser)
        }
    }
}

struct OrdersView: View {
    @ObservedResults(RealmDatabaseUser.self) var realmDatabaseUser
    @StateObject private var viewModel = OrdersViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                if let user = viewModel.user?.orders {
                    if user.isEmpty {
                        VStack {
                            Image("emptyOrder")
                            
                            Text("Your order history is empty.")
                                .font(.custom(AppFonts.bold, size: 20))
                                .padding(.bottom)
                            
                            Text("Explore our collection and place an order.")
                                .font(.custom(AppFonts.regular, size: 18))
                                .foregroundStyle(AppColors.lightGray)
                                .padding(.horizontal)
                        }
                    }
                    
                    ForEach(user, id: \.id) { order in
                        OrderItem(item: order)
                            .padding(.bottom, 5)
                    }
                    
                }
            }
            .onAppear {
                Task {
                    try await viewModel.fetchOrders()
                }
            }
        }
        .padding(.horizontal)
        .background(
            AppColors.primaryLightGray
                .ignoresSafeArea())
        .padding(.top, 30)
    }
}




#Preview {
    OrdersView()
    //    OrderItem(item: DatabaseUserOrder(uid: "djfkfn7932j3n4o3no",
    //                                      productImage: "acer-1",
    //                                      productname: "Acer", price: 4555))
}
