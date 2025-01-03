//
//  HomeViewModel.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/11.
//

import Foundation
import RealmSwift


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
    
    func getJsonData() -> [CategoryModel] {
        let dataFromJSON = [
            CategoryModel(imageName: "laptops",
                          color: "primaryGreen",
                          productModel:
                           laptops,
                          name: "Laptops"),
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
        self.laptops = try await productProvider.getProductItems(from: "laptops", collection: "laptop")
        self.phones = try await productProvider.getProductItems(from: "phones", collection: "phone")
        self.headphones = try await productProvider.getProductItems(from: "headphones", collection: "headphone")
        self.televisions = try await productProvider.getProductItems(from: "televisions", collection: "television")
    }
    func getFirstWord(word: String) -> String {
        let wordComponent = word.split(separator: " ")
        
        if let firstWord = wordComponent.first {
            return String(firstWord)
        }
        return ""
    }
}
