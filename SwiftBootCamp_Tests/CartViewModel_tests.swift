//
//  SwiftBootCamp_Tests.swift
//  SwiftBootCamp_Tests
//
//  Created by Ontiretse Motlagale on 2024/06/13.
//

import XCTest
@testable import Crunch_App

final class CartViewModel_tests: XCTestCase {
    
    var viewModel: CartViewModel?
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = CartViewModel(realmManager: RealmManager())
    }
    
    override func tearDownWithError() throws {
        // Put teardown code. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testCartViewModel_total_ShouldStartAsZero() {
        XCTAssertEqual(viewModel?.total, viewModel?.total)
    }
    
    func testCartViewModel_tota_ShouldNotStartAsMoreThanZero() {   
        XCTAssertNotEqual(viewModel?.total, 1)
    }
    
    func testCartViewModeel_useableCartItems_ShouldStartAsEmpty() {
        XCTAssertNotNil(viewModel?.useableCartItems)
    }
    
    func testCartViewModel_total_ShouldIncreaseWithItemsAppending() {
        let items: UsableCartItems = UsableCartItems(name: "Laptop", image: "", price: 12, descript: "")
        
        viewModel?.useableCartItems.append(items)
        
        XCTAssertEqual(viewModel?.useableCartItems.count, viewModel?.useableCartItems.count)
    }
    
    func testCartViewModel_mapUsableCartItems_shouldAssign() {
        viewModel?.mapUsableCartItems()
        
        XCTAssertEqual(viewModel?.useableCartItems.count, viewModel?.useableCartItems.count)
        
    }
    func testCartViewModel_total_AfterItemsHaveBeenAdded(){
        let items: UsableCartItems = UsableCartItems(name: "Laptop", image: "", price: 14, descript: "")
       
        viewModel?.useableCartItems.append(items)
        viewModel?.calculatePrice()
        
        XCTAssertEqual(viewModel?.total, viewModel?.total)
    }
}

