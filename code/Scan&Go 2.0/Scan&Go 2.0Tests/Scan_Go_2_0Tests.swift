//
//  Scan_Go_2_0Tests.swift
//  Scan&Go 2.0Tests
//
//  Created by Dinuka Dissanayake on 5/19/24.
//

import XCTest
@testable import Scan_Go_2_0

final class Scan_Go_2_0Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTotalPriceCalculation() {
        // Given
        let cartItems: [CartItem] = [
            CartItem(image: Image("butter"), name: "Anchor Butter", price: 400.00, description: "This is item 1", quantity: 1),
            CartItem(image: Image("juice"), name: "Orange Juice", price: 290.00, description: "This is item 2", quantity: 2),
        ]
        let cartView = CartView(cartItems: cartItems)
        
        // When
        let totalPrice = cartView.totalPrice()
        
        // Then
        XCTAssertEqual(totalPrice, "LKR 980.00")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
