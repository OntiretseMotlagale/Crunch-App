
import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    var body: some View {
        NavigationStack {
            VStack {
                Image("bg")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                Text("Login")
                    .font(.custom(AppFonts.bold, size: 30))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20)
                InputText(value: $viewModel.email, placeholder: "Email Address", iconname: .envelope)
                SecureText(iconname: .lock, placeholder: "Password", value: $viewModel.password)
                
                CustomButton(title: "LOG IN") {
                    Task {
                       try await viewModel.signIn()
                    }
                }
                    .padding(.bottom, 10)
                HStack {
                    Text("Don't have an account ?")
                        .font(.custom(AppFonts.regular, size: 15))
                    NavigationLink {
                        RegisterView()
                    } label: {
                        Text("Register")
                            .font(.custom(AppFonts.bold, size: 15))
                            .foregroundStyle(LinearGradient(colors: [AppColors.primaryColor, AppColors.secondayColor], startPoint: .center, endPoint: .center))
                    }
                }
                .padding(.top, 10)
                .font(.subheadline)
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    LoginView()
}

struct CustomButton: View {
    var title: String
    var buttonAction: () -> ()
    var body: some View {
        Button(action: {
            buttonAction()
        }, label: {
            Text(title)
                .font(.custom(AppFonts.bold, size: 17))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(LinearGradient(colors: [AppColors.primaryColor, AppColors.secondayColor], startPoint: .center, endPoint: .center)))
        })
    }
}
