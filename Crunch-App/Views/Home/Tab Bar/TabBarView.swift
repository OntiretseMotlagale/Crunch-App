
import SwiftUI

enum Tab: String, CaseIterable {
    case home
    case search
    case cart
    case profile
}

struct TabBarItem: Identifiable {
    var id = UUID()
    var iconName: String
    var tab: Tab
    var index: Int
}

struct TabBarView: View {
    let imageName: Tab = .home
    var body: some View {
        VStack {
            
        }
    }
}
//struct TabBarView: View {
//    let tabItems: [TabBarItem] = [
//        TabBarItem(iconName: "house", tab: .home, index: 0),
//        TabBarItem(iconName: "magnifyingglass", tab: .search, index: 1),
//        TabBarItem(iconName: "cart", tab: .cart, index: 2),
//        TabBarItem(iconName: "person", tab: .profile, index: 3)]
//    @State var selectedTab: Tab = .home
//    @State var xOffset: Double = 0.0
//    var body: some View {
//        NavigationStack {
//            VStack {
//                VStack {
//                    RootView(selectedTab: $selectedTab)
//                    Spacer()
//                }
//                HStack {
//                    ForEach(tabItems) { item in
//                        Spacer()
//                        Image(systemName: item.iconName)
//                            .resizable()
//                            .frame(width: 20, height: 20)
//                            .foregroundStyle(selectedTab == item.tab ? .white : .gray)
//                            .onTapGesture {
//                                withAnimation(.spring()) {
//                                    selectedTab = item.tab
//                                    xOffset = Double(item.index * 94)
//                                }
//                            }
//                        Spacer()
//                    }
//                }
//                .frame(height: 70)
//                .background(Color.black)
//                .cornerRadius(10)
//                .padding(.horizontal, 10)
//                .overlay(alignment: .bottomLeading) {
//                    Circle()
//                        .fill(.white)
//                        .frame(width: 10, height: 10)
//                        .offset(x: 50, y: -5)
//                        .offset(x: xOffset)
//                        .padding(.bottom, 3)
//                }
//            }
//            .navigationBarBackButtonHidden()
//        .navigationBarBackButtonHidden(true)
//        }
//    }
//}

#Preview {
    NavigationStack {
        TabBarView()
    }
}

struct RootView: View {
    @Binding var selectedTab: Tab
    var body: some View {
        switch selectedTab {
        case .home:
            HomeView()
        case .search:
            Text("Search")
        case .cart:
            CartView(realmManager: RealmManager())
        case .profile:
            ProfileView()
        }
    }
}
