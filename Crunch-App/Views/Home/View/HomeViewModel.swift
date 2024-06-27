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

class HomeViewModel: ObservableObject {
    
    @Published var laptops: [DatabaseProductItem] = []
    @Published var headphones: [DatabaseProductItem] = []
    @Published var phones: [DatabaseProductItem] = []
    @Published var televisions: [DatabaseProductItem] = []
    
    @Inject var firestoreManager: FirestoreManagerProtocol
    
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
        self.laptops = try await firestoreManager.fetchProductItems(from: "laptops", collectionName: "laptop")
        self.phones = try await firestoreManager.fetchProductItems(from: "phones", collectionName: "phone")
        self.headphones = try await firestoreManager.fetchProductItems(from: "headphones", collectionName: "headphone")
        self.televisions = try await firestoreManager.fetchProductItems(from: "televisions", collectionName: "television")
    }
    func getFirstWord(word: String) -> String {
        let wordComponent = word.split(separator: " ")
        
        if let firstWord = wordComponent.first {
            return String(firstWord)
        }
        return ""
    }
}
