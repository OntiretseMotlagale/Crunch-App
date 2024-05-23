import SwiftUI

struct CartItem: View {
    let item: UsableCartItems
    @StateObject private var viewModel: CartViewModel
    
    init(cartViewModel: CartViewModel, item: UsableCartItems) {
        self.item = item
    _viewModel = StateObject(wrappedValue: CartViewModel(realmManager: RealmManager()))
    }
    
    var body: some View {
            HStack (alignment: .center) {
                Image(item.image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(Color(AppColors.primaryLightGray)))
                    .shadow(color: Color.black.opacity(0.2), radius: 1, x: 0, y: 0.3)
                VStack(alignment: .leading, spacing: 20) {
                    Text(item.name)
                        .font(.title3)
                        .fontWeight(.thin)
                    HStack (alignment: .center) {
                        Text("Price:")
                            .font(.footnote)
                        Text("R\(item.price)")
                            .font(.footnote)
                            .fontWeight(.ultraLight)
                        Spacer()
                        HStack(alignment: .center) {
                            QuantityButton(imageName: "minus") {
                                viewModel.decreaseNumberOfItems()
                            }
                            Text("\(viewModel.numberOfItems)")
                                .font(.caption)
                                .fontWeight(.bold)
                                .foregroundStyle(.black)
                            QuantityButton(imageName: "plus") {
                                viewModel.increaseNumberOfItems()
                            }
                        }
                        .padding(.trailing, 2)
                    }
                }
            }
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 5)
                .fill(.white))
            .cornerRadius(10)
            .navigationTitle("My Cart")
            .navigationBarTitleDisplayMode(.inline)
    }
    
    struct QuantityButton: View {
        let imageName: String
        var buttonAction: () -> ()
        var body: some View {
            Button(action: {
                buttonAction()
            }, label: {
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 8)
                    .foregroundColor(.white)
                    .padding(8)
                    .frame(width: 25, height: 25)
                    .background(RoundedRectangle(cornerRadius: 5)
                        .fill(Color(AppColors.primaryColor)))
            })
        }
    }
}

#Preview {
    CartItem(cartViewModel: CartViewModel(realmManager: RealmManager()),
             item: UsableCartItems(name: "Acer Laptop",
                                   image: "acer-1",
                                   price: 13999,
                                   descript: "fhkhf foinfif"))
}
