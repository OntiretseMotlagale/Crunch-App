//
//  HomeViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/11.
//

import Foundation
import RealmSwift

struct DatabaseProductItem: Identifiable {
    var id: String = UUID().uuidString
    var gallery: [String]?
    var description: String?
    var image: String?
    var name: String?
    var price: Int?
}
struct CategoryModel: Identifiable {
    var id = UUID()
    var imageName: String
    var color: String
    var productModel: [DatabaseProductItem]
    var name: String
}

protocol HomeViewProtocol {
    func getJsonData() -> [CategoryModel]
    func getFirstWord(word: String) -> String 
}

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published private var laptops: [DatabaseProductItem] = []
    @Published private var headphones: [DatabaseProductItem] = []
    @Published private var phones: [DatabaseProductItem] = []
    @Published private var televisions: [DatabaseProductItem] = []
    
    @Inject var productProvider: ProductProvider
    
    func getProductItems() async throws {
        do {
            try await setupProductItems()
        } catch {
            print(error.localizedDescription)
        }
    }
    func getJsonData() -> [CategoryModel] {
        let dataFromJSON = [
            CategoryModel(imageName: "laptops",
                          color: "primaryGreen",
                          productModel:
                           laptops,
                          name: "Phones"),
            CategoryModel(imageName: "phones",
                          color: "primaryPink",
                          productModel: phones,
                          name: "Phones"),
            CategoryModel(imageName: "headphones",
                          color: "TextColor",
                          productModel: headphones,
                          name: "Headphones"),
            CategoryModel(imageName: "televisions",
                          color: "primaryPurple",
                          productModel: televisions,
                          name: "Television")]
        return dataFromJSON
    }
    
    func setupProductItems() async throws {
        self.laptops = try await productProvider.fetchProductItems(from: "laptops", collection: "laptop")
        self.phones = try await productProvider.fetchProductItems(from: "phones", collection: "phone")
        self.headphones = try await productProvider.fetchProductItems(from: "headphones", collection: "headphone")
        self.televisions = try await productProvider.fetchProductItems(from: "televisions", collection: "television")
    }
    func getFirstWord(word: String) -> String {
        let wordComponent = word.split(separator: " ")
        
        if let firstWord = wordComponent.first {
            return String(firstWord)
        }
        return ""
    }
}
