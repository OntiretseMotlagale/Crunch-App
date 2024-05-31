//
//  SuccessState.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/05/23.
//

import SwiftUI
import AlertKit

struct SuccessState: View {
    @State var animateCircle: Bool = true
    @ObservedObject var viewModel: CartViewModel
    @Binding var show: Bool
    var icon = "successImage"
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(maxHeight: .infinity)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .clear, .green]), startPoint: .top, endPoint: .bottom))
                    .opacity(0.4)
                    .offset(y: show ? 0 : 300)
                ZStack {
                    VStack (spacing: 10){
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 7)
                                .foregroundStyle(.green)
                                .frame(width: 250, height: 250)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2)
                                    .delay(0.0)
                                    .repeatForever(autoreverses: false), value: animateCircle)
                            Circle()
                                .stroke(lineWidth: 7)
                                .foregroundStyle(.green)
                                .frame(width: 250, height: 250)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2)
                                    .delay(1.5)
                                    .repeatForever(autoreverses: false), value: animateCircle)
                                .onAppear {
                                    animateCircle.toggle()
                                }
                            Image(icon)
                                .resizable()
                                .frame(width: 240, height: 240)
                        }
                        VStack (spacing: 10 ){
                            Text("Payment Successfully!")
                                .font(.system(size: 30))
                                .fontWeight(.bold)
                                .padding(.top, 80)
                            Group {
                                Text("We have received payment amount of ") +
                                Text("R\(viewModel.total)")
                                    .fontWeight(.bold)
                                    .font(.callout)
                            }
                            .font(.callout)
                            .padding(.horizontal, 4)
                            
                        }
                    }
                    
                }.padding(.horizontal, 5)
                    .offset(y: show ? -30 : 300)
            }
            .onChange(of: show) { oldValue, newValue in
                if newValue {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                        withAnimation {
                            show = false
                        }
                    })
                }
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SuccessState(viewModel: CartViewModel(realmManager: RealmManager()), show: .constant(true))
}
