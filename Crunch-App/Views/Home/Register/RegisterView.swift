import SwiftUI
import AlertKit

enum AuthIcons: String {
    case person
    case envelope
    case lock
}
struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dimiss
    @AppStorage("isUserSignedIn") var isUserSignedIn: Bool = false
    
    var body: some View {
        ScrollView {
            VStack {
                VStack {
                    Image("bg")
                        .resizable()
                        .scaledToFit()
                    .frame(width: 150, height: 150)
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 20)
                    InputText(value: $viewModel.fullName, placeholder: "Full Name", iconname: .person)
                    InputText(value: $viewModel.email, placeholder: "Email Address", iconname: .envelope)
                    SecureText(iconname: .lock, placeholder: "Password", value: $viewModel.password)
                        .padding(.bottom, 10)
                }
                .padding(.bottom)
                VStack (spacing: 10) {
                    CustomButton(title: "SIGN UP") {
                        Task {
                            try await  viewModel.register()
                        }
                    }
                    HStack {
                        RoundedRectangle(cornerSize: CGSize())
                            .frame(width: 50, height:  1)
                        Text("or continue with")
                            .font(.custom(AppFonts.regular, size: 17))
                        RoundedRectangle(cornerSize: CGSize())
                            .frame(width: 50, height:  1)
                    }
                    .foregroundStyle(Color("PrimaryGray"))
                    HStack (spacing: 30) {
                        AuthenticationButton(imageName: "google", buttonAction: {
                            Task {
                               try await viewModel.registerWithGoogle()
                            }
                        })
                    }
                    HStack {
                        Text("Already have an account ?")
                            .font(.custom(AppFonts.regular, size: 15))
                        Button(action: {
                            dimiss()
                        }, label: {
                            Text("Login")
                                .foregroundStyle(Color("TertiaryBlue"))
                                .font(.custom(AppFonts.bold, size: 15))
                        })
                    }
                    .padding(.top, 10)
                    .font(.subheadline)
                }
            }
            .padding()
        }
        .navigationBarBackButtonHidden()
        .navigationBarBackButtonHidden(true)
        .fullScreenCover(isPresented: $isUserSignedIn, content: {
            HomeView()
        })
        .alert(isPresent: $viewModel.isAccountCreated, view: AlertAppleMusic16View(subtitle: "Account Successfully Created"))
        .alert(isPresented: $viewModel.showAlert) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

#Preview {
    AuthenticationButton(imageName: "google", buttonAction: {})
}

struct SecureText: View {
    let iconname: AuthIcons
    let placeholder: String
    @Binding var value: String
    
    var body: some View {
        VStack {
            HStack (spacing: 10) {
                Image(systemName: iconname.rawValue)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color("PrimaryGray"))
                    .frame(width: 20, height: 20)
                SecureField(text: $value) {
                    Text(placeholder)
                        .font(.custom(AppFonts.regular, size: 16))
                }
            }
            .padding()
            .frame(height: 60)
            .background(
            Color("PrimaryBlue"))
            .cornerRadius(10)
            .padding(.bottom, 9)
        }
    }
}
struct InputText: View {
    @Binding var value: String
    let placeholder: String
    let iconname: AuthIcons
    var body: some View {
        VStack {
            HStack (spacing: 10) {
                Image(systemName: iconname.rawValue)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(Color("PrimaryGray"))
                    .frame(width: 20, height: 20)
                TextField(text: $value) {
                    Text(placeholder)
                        .font(.custom(AppFonts.regular, size: 16))
                }
                .autocorrectionDisabled(true)
            }
            .padding()
            .frame(height: 60)
            .background(
            Color("PrimaryBlue"))
            .cornerRadius(10)
            .padding(.bottom, 10)
        }
    }
}

struct AuthenticationButton: View {
    let imageName: String
    let buttonAction: () -> ()
    var body: some View {
        VStack {
            Button(action: {
                buttonAction()
            }, label: {
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40, height: 40)
                    .padding(8)
                    .background(
                        Color("PrimaryLightGray"))
                    .cornerRadius(50)
                Text("Continue With Google")
                    .font(.custom(AppFonts.bold, size: 14))
                    .foregroundStyle(.black)
                   
            })
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(Color("PrimaryBlue")))
        }
    }
}
