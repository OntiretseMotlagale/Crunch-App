//
//  ProductDetailViewModel_Tests.swift
//  SwiftBootCamp_Tests
//
//  Created by Ontiretse Motlagale on 2024/06/14.
//

import XCTest
@testable import Crunch_App

final class ProductDetailViewModel_Tests: XCTestCase {
    var viewModel: ProductDetailViewModel?
    var realmManager: RealmManager?
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        realmManager = RealmManager()
        viewModel = ProductDetailViewModel(realmManager: self.realmManager!)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        realmManager = nil
    }
    
    func testProductDetailViewModel_addItemToRealm() {
        let productItem: ProductModel = ProductModel(id: 0, name: "iPhone", image: "iPhone 15", description: "", price: 2, gallery: [""])
        
        viewModel?.addItemToRealm(item: productItem)
        
        XCTAssertEqual(realmManager?.fetchRealmItems().count, realmManager?.fetchRealmItems().count)
    }

}
