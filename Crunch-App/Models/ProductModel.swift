import Foundation

struct ProductModel: Codable, Identifiable, Equatable {
    var id: Int
    var name: String
    var image: String
    var description: String
    var price: Int
    var gallery: [String]
}
    
