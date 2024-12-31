//
//  OnoboardingView.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/11/25.
//

import SwiftUI

struct OnboardingView: View {
    @AppStorage("isOnboardingDone") var isOnboardingDone: Bool = false
    @State var showSheet: Bool = false
    @State var isImageAnimating1: Bool = false
    @State var isImageAnimating2: Bool = false
    @State var isImageAnimating3: Bool = false
    @State var onboardingStates: Int = 0
    let transition: AnyTransition = .asymmetric(
        insertion: .move(edge: .trailing),
        removal: .move(edge: .leading ))
    
    var body: some View {
        VStack {
                switch onboardingStates {
                case 0:
                    onboardingImageView(isImageAnimating: $isImageAnimating1, 
                                        imageName: "iPhone-1",
                                        transition: transition)
                case 1:
                    onboardingImageView(isImageAnimating: $isImageAnimating2, 
                                        imageName: "airpods-1",
                                        transition: transition)
                case 2:
                    onboardingImageView(isImageAnimating: $isImageAnimating3,
                                        imageName: "macbook-1",
                                        transition: transition)
                default:
                    RoundedRectangle(cornerRadius: 20)
                }
                Spacer()
        }
        .onAppear {
            self.showSheet = true
        }
        .sheet(isPresented: $showSheet) {
          
            switch onboardingStates {
            case 0:
                firstBottomView
                    .modifier(DismissDiabledSheet())
                    .transition(transition)
            case 1:
                secondBottomView
                    .modifier(DismissDiabledSheet())
                    .transition(transition)
            case 2:
                thirdBottomView
                    .modifier(DismissDiabledSheet())
                    .transition(transition)
            default:
                RoundedRectangle(cornerRadius: 10)
                    .fill(.black)
            }
            nextButton
        }
    }
}

#Preview {
    OnboardingView()
}

struct onboardingImageView: View {
    @Binding var isImageAnimating: Bool
    let imageName: String
    let transition: AnyTransition
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .transition(transition)
            .scaleEffect(isImageAnimating ? 1.0 : 0.6)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.6)) {
                    self.isImageAnimating = true
                }
            }
    }
    
}
extension OnboardingView {
    
    func handleNextButtonPressed() {
        if onboardingStates <= 1 {
            onboardingStates += 1
        } else {
          self.isOnboardingDone = true
        }
    }
}

extension OnboardingView {
    
    private var nextButton: some View {
        
        Button(action: {
            withAnimation(.spring()) {
                handleNextButtonPressed()
            }
        }, label: {
            Text(onboardingStates == 0 ? "Next" : onboardingStates == 2 ? "Let's get started" : "Next")
                .fontWeight(.semibold)
                .foregroundStyle(onboardingStates == 2 ? .white : .black)
                .frame(height: 55)
                .frame(maxWidth: .infinity)
                .background(onboardingStates == 2 ? AppColors.primaryColor : .lightGray.opacity(0.2))
                .cornerRadius(20)
        })
        .padding()
    }
    
    private var firstBottomView: some View {
        VStack (spacing: 20) {
            HStack {
                Image(systemName: "1.circle.fill")
                    .resizable()
                    .scaledToFit()
                .frame(width: 20, height: 20)
                Text("/")
                Image(systemName: "3.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            Text("Explore the Latest Tech.")
                .font(.title)
                .fontWeight(.semibold)
            Text("Discover a wide range of cutting-edge electronics, from powerful laptops to high-quality headphones and the latest smartphones, all in one place")
                .font(.body)
                .foregroundStyle(.lightGray)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(35)
    }
    
    private var secondBottomView: some View {
        VStack (spacing: 20) {
            HStack {
                Image(systemName: "2.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                Text("/")
                Image(systemName: "3.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            Text("Shop with Confidence.")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("Enjoy secure shopping, detailed product descriptions, and trusted reviews to make informed decisions for your tech needs.")
                .foregroundStyle(.lightGray)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(35)
    }
    
    private var thirdBottomView: some View {
        VStack(spacing: 20) {
            HStack {
                Image(systemName: "3.circle.fill")
                    .resizable()
                    .scaledToFit()
                .frame(width: 30, height: 30)
                Text("/")
                Image(systemName: "3.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
            }
            Text("Fast and Reliable Delivery.")
                .font(.title)
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
            Text("Get your favorite gadgets delivered to your doorstep quickly and hassle-free, with seamless tracking and updates")
                .foregroundStyle(.lightGray)
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
        }
        .padding(35)
    }
    
    
}
