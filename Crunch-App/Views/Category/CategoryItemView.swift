
import SwiftUI

struct CategoryItemView: View {
    let column: [GridItem] = [
        GridItem(.flexible(), spacing: 5, alignment: nil),
        GridItem(.flexible(), spacing: 5, alignment: nil)
    ]
    let item: [ProductModel]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: column, spacing: 10) {
                ForEach(item) { item in
                    NavigationLink {
                        ProductDetailView(item: item)
                    } label: {
                        VStack (alignment: .center) {
                            Image(item.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150, height: 150)
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 15))
                                    .fontWeight(.thin)
                                    .padding(.bottom, 3)
                                Text( item.description)
                                    .font(.caption)
                                    .foregroundStyle(Color.gray)
                                    .frame(width: 100)
                                    .lineLimit(1)
                                    .truncationMode(.tail)
                                    .padding(.bottom, 4)
                                HStack {
                                    Text("Price:")
                                        .font(.footnote)
                                        .fontWeight(.semibold)
                                        .foregroundColor(.black)
                                    Spacer()
                                    Text("R\(item.price)")
                                        .font(.footnote)
                                        .fontWeight(.bold)
                                        .foregroundColor(.black)
                                }
                            }
                            .padding(6)
                            .background(
                                RoundedRectangle(cornerRadius: 5)
                                    .fill(.white))
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color("PrimaryGray").opacity(0.2)))
                    }
                }
            }
        }
    }
}
#Preview {
    CategoryItemView(item: [
        ProductModel(id: 12, name: "Asus", image: "acer-1", description: "jfkjdffdfdjfg dfff rerreer ewweewewew", price: 4000, gallery: [""]),
        ProductModel(id: 12, name: "Asus", image: "acer-1", description: "jfkjjfg", price: 4000, gallery: [""]),
        ProductModel(id: 12, name: "Asus", image: "acer-1", description: "jfkjjfg", price: 4000, gallery: [""])
    ])
}
