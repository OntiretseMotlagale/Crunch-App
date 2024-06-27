
import SwiftUI

struct CategoryItemView: View {
   
    let column: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil)
    ]
    let item: [DatabaseProductItem]
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: column, spacing: 20) {
                ForEach(item) { item in
                    NavigationLink {
                        ProductDetailView(item: item)
                    } label: {
                        VStack (alignment: .center, spacing: 0) {
                            VStack {
                                GroupBox {
                                    if let image = item.image {
                                        Image(item.image!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 150, height: 150)
                                    }
                                }
                                VStack (alignment: .leading, spacing: 5) {
                                    HStack {
                                        if let name = item.name {
                                            Text(name)
                                                .font(.custom(AppFonts.semibold, size: 15))
                                                .foregroundStyle(.black)
                                                .multilineTextAlignment(.leading)
                                        }
                                        Spacer()
                                        Image(systemName: "star.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundStyle(Color("primaryGold"))
                                        Text("4.0")
                                            .font(.custom(AppFonts.bold, size: 15))
                                            .foregroundStyle(.black)
                                    }
                                    if let description = item.description,
                                       let price = item.price {
                                        Text(description)
                                            .font(.custom(AppFonts.regular, size: 14))
                                            .foregroundStyle(.gray)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(1)
                                            .padding(.bottom, 10)
                                        Text("R\(price)")
                                            .font(.custom(AppFonts.bold, size: 17))
                                            .foregroundStyle(.black)
                                            .padding(.top, 5)
                                    }
                                   
                                }
                                .padding(.vertical, 4)
                                .padding(.horizontal, 10)
                            }
                            .padding(.bottom)
                        }
                        .frame(width: 185)
                        .background(.white, in: RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
        }
        .background(
            Color(AppColors.primaryLightGray)
                .ignoresSafeArea())
    }
}
//#Preview {
//    CategoryItemView(item: [
//        ProductModel(id: 12, name: "Samsung Galaxy", image: "acer-1", description: "Experience the perfect blend of power, portability, and style with the Connex 14 Celeron N4020 4/128SSD W11 Home laptop. Engineered to enhance your productivity and simplify your digital lifestyle", price: 4000, gallery: [""]),
//        ProductModel(id: 12, name: "Asus", image: "acer-1", description: "jfkjjfg", price: 4000, gallery: [""]),
//        ProductModel(id: 12, name: "Asus", image: "acer-1", description: "jfkjjfg", price: 4000, gallery: [""])
//    ])
//}
