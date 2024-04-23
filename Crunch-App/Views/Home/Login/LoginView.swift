
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
                    .font(.largeTitle)
                    .fontWeight(.bold)
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
                    NavigationLink {
                        RegisterView(authService: AuthenticationManager())
                    } label: {
                        Text("Register")
                            .foregroundStyle(Color("TertiaryBlue"))
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
                .font(.headline)
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color("LightBlue")))
        })
    }
}
