

import Foundation

struct CategoryItem: Codable, Identifiable {
    var id = UUID()
    let imageName: String
    let itemName: String
}
