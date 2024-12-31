
import SwiftUI
import RealmSwift

enum Tab: String, CaseIterable {
    case home
    case favourite
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
    let tabItems: [TabBarItem] = [
        TabBarItem(iconName: "house.fill", tab: .home, index: 0),
        TabBarItem(iconName: "heart.fill", tab: .favourite, index: 1),
        TabBarItem(iconName: "cart.fill", tab: .cart, index: 2),
        TabBarItem(iconName: "person.fill", tab: .profile, index: 3)]
    
    @State var selectedTab: Tab = .home
    @State var xOffset: Double = 0.0
    @ObservedResults(RealmProductItem.self) var cartItems
    var body: some View {
            VStack {
                VStack {
                    RootView(selectedTab: $selectedTab)
                    Spacer()
                }
                HStack {
                    ForEach(tabItems) { item in
                        Spacer()
                        Image(systemName: item.iconName)
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(selectedTab == item.tab ? .black : Color(AppColors.lightGray))
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    selectedTab = item.tab
                                    xOffset = Double(item.index * 104)
                                }
                            }
                        Spacer()
                    }
                }
                .frame(height: 70)
                .background(.white)
                .cornerRadius(10)
                .padding(.horizontal, 10)
                .overlay(alignment: .bottomLeading) {
                    Circle()
                        .fill(.black)
                        .frame(width: 10, height: 10)
                        .offset(x: 55, y: -5)
                        .offset(x: xOffset)
                        .padding(.bottom, 3)
                }
                .overlay(alignment: .topTrailing) {
                    if !cartItems.isEmpty {
                        Text("\(cartItems.count)")
                                .font(.caption2)
                                .foregroundColor(.white)
                                .padding(5)
                                .background(Color.red)
                                .clipShape(Circle())
                                .offset(x: -147, y: 9)
                    }
                }
            }
            .navigationBarBackButtonHidden()
            .navigationBarBackButtonHidden(true)
            .background(Color(AppColors.primaryLightGray)
                .ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        TabBarView()
    }
}

struct RootView: View {
    @Binding var selectedTab: Tab
    var body: some View {
            VStack {
                switch selectedTab {
                case .home:
                    HomeView()
                case .favourite:
                    FavouriteView()
                case .cart:
                    CartView(realmManager: RealmManager())
                case .profile:
                    ProfileView()
                }
            }
    }
}
