
import SwiftUI
import AlertKit

struct SuccessState: View {
    @ObservedObject var viewModel: CartViewModel
    @Binding var show: Bool
    
    @State var animateCircle: Bool = true
    @State private var showHomeScreen: Bool = false

    var icon = "successImage"
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .frame(maxHeight: .infinity)
                    .foregroundStyle(LinearGradient(gradient: Gradient(colors: [.clear, .clear, Color(AppColors.primaryColor)]), startPoint: .top, endPoint: .bottom))
                    .opacity(0.4)
                    .offset(y: show ? 0 : 300)
                ZStack {
                    VStack (spacing: 10){
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 7)
                                .foregroundStyle(.mint)
                                .frame(width: 250, height: 250)
                                .scaleEffect(animateCircle ? 1.3 : 0.90)
                                .opacity(animateCircle ? 0 : 1)
                                .animation(.easeInOut(duration: 2)
                                    .delay(0.0)
                                    .repeatForever(autoreverses: false), value: animateCircle)
                            Circle()
                                .stroke(lineWidth: 7)
                                .foregroundStyle(.mint)
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
                            Text("Payment Successful!")
                                .font(.custom(AppFonts.bold, size: 30))
                                .fontWeight(.bold)
                                .padding(.top, 80)
                                .foregroundStyle(.black.opacity(0.8))
                                Text("We have received payment amount of ")
                                    .font(.custom(AppFonts.regular, size: 20))
                                    .foregroundStyle(Color(AppColors.lightGray))
                                Text("R\(viewModel.total)")
                                    .font(.custom(AppFonts.bold, size: 30))
                            .padding(.horizontal)
                            .padding(.bottom, 30)
                            Button(action: {
                                withAnimation(.easeInOut(duration: 0.5)){
                                    showHomeScreen = true
                                    viewModel.deleteAll()
                                }
                            }, label: {
                                HStack(spacing: 20) {
                                  Image(systemName: "arrow.left")
                                        .foregroundStyle(.white)
                                        .font(.custom(AppFonts.bold, size: 16))
                                    Text("Home")
                                        .font(.custom(AppFonts.semibold, size: 23))
                                        .foregroundStyle(.white)
                                }
                            })
                            .frame(width: 200)
                            .padding()
                            .background(
                            RoundedRectangle(cornerRadius: 30))
                          
                        }
                    }
                }.padding(.horizontal, 5)
                    .offset(y: show ? -30 : 300)
                if showHomeScreen {
                    TabBarView()
                }
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
