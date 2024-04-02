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
    var productModel: [ProductModel]
    var name: String
}

class HomeViewModel: ObservableObject {
    
    let dataService = DataService()
    
    func getData() -> [CategoryModel] {
        let laptopData = [
            CategoryModel(imageName: "laptops", 
                          color: "primaryGreen",
                          productModel:
                            dataService.laptop,
                          name: "Laptops"),
            CategoryModel(imageName: "phones", 
                          color: "primaryPink",
                          productModel: dataService.phone,
                          name: "Phones"),
            CategoryModel(imageName: "headphones", 
                          color: "LightBlue",
                          productModel: dataService.headphones,
                          name: "Headphones"),
            CategoryModel(imageName: "televisions", 
                          color: "primaryPurple",
                          productModel: dataService.television,
                          name: "Television")]
        return laptopData
    }
}
