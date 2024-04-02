//
//  DataService.swift
//  Crunch-App
//
//  Created by Ontiretse Motlagale on 2024/03/19.
//

import Foundation


class DataService: ObservableObject {
    @Published var laptop: [ProductModel] = Bundle.main.decode("laptop.json")
    @Published var phone: [ProductModel] = Bundle.main.decode("phones.json")
    @Published var television: [ProductModel] = Bundle.main.decode("television.json")
    @Published var headphones: [ProductModel] = Bundle.main.decode("headphones.json")
}
