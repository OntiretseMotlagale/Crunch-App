//
//  PaymentSuccessView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/05/23.
//

import SwiftUI
import AlertKit


struct PaymentSuccessView: View {
    @State var animate: Bool = true
    var body: some View {
        ZStack {
            VStack {
                SuccessState(viewModel: CartViewModel(realmManager: RealmManager()), show: $animate)
            }
        }
    }
}



#Preview {
    PaymentSuccessView()
}
