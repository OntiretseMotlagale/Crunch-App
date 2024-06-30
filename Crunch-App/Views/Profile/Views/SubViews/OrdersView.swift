//
//  OrdersView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI
import FirebaseAuth

@MainActor
class OrdersViewModel: ObservableObject {
    @Published private(set)var orders: [DatabaseUserOrder] = []
    @Inject var firestoreManager: FirestoreManagerProtocol
    
    func fetchOrders() async throws {
        guard let authUser = Auth.auth().currentUser?.uid else {
            return
        }
        do {
            self.orders = try await firestoreManager.fetchOrderItems(userID: authUser)
        }
    }
}

struct OrdersView: View {
    @StateObject private var viewModel = OrdersViewModel()
    
    var body: some View {
        VStack {
            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderItem(item: order)
                        .padding(.bottom, 10)
                }
            }
            .listStyle(.insetGrouped)
        }
        .onAppear {
            Task {
                try await viewModel.fetchOrders()
            }
        }
    }
}

struct OrderItem: View {
    let item: DatabaseUserOrder
    var body: some View {
        HStack (alignment: .center) {
            
            if let image = item.productImage {
                Image(image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 0.3)
            }
            VStack(alignment: .leading, spacing: 20) {
                if let name = item.productImage {
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
        .background(RoundedRectangle(cornerRadius: 5)
            .fill(.white))
        .cornerRadius(10)
        .navigationTitle("My Order")
        .navigationBarTitleDisplayMode(.inline)
    }
}



#Preview {
    OrdersView()
//    OrderItem(item: DatabaseUserOrder(uid: "djfkfn7932j3n4o3no",
//                                      productImage: "acer-1",
//                                      productname: "Acer", price: 4555))
}
