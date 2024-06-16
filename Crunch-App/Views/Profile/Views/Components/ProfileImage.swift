//
//  ProfileImage.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/04/23.
//

import SwiftUI

struct ProfileImage: View {
    var body: some View {
        ZStack {
            Image("profile")
                .resizable()
                .scaledToFit()
                .frame(width: 130, height: 130)
                .background {
                    Circle()
                        .fill(Color("PrimaryGray"))
                }
            HalfCircle()
                .stroke(AppColors.primaryColor, lineWidth: 5)
                .frame(width: 155, height: 125)
        }
        .clipped()
    }
}

#Preview {
    ProfileImage()
}
struct HalfCircle: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let startAngle = Angle(degrees: 120)
        let endAngle = Angle(degrees: 5)
        
        var path = Path()
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path
    }
}

