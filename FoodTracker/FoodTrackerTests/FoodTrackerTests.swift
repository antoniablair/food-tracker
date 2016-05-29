//
//  FoodTrackerTests.swift
//  FoodTrackerTests
//
//  Created by Antonia Blair on 5/16/16.
//  Copyright © 2016 Antonia Blair. All rights reserved.
//
import UIKit
import XCTest
@testable import FoodTracker

class FoodTrackerTests: XCTestCase {
    // MARK: FoodTracker Tests
    
    // Tests to confirm that the Meal initializer returns when no name or negative raiting is provided.
    func testMealInitialization() {
        // Success case. Create a new Meal
        let potentialItem = Meal(name: "Newest meal", photo: nil, rating: 5)
        // asserts that Meal is not nil
        XCTAssertNotNil(potentialItem)
        print (Meal)
        
        // Failure cases.
        let noName = Meal(name: "", photo: nil, rating: 0)
        XCTAssertNil(noName, "Empty name is invalid")
        
        let badRating = Meal(name: "Really bad rating", photo: nil, rating: -1)
        XCTAssertNil(badRating, "Negative ratings are invalid, be positive")
    }
    
}
