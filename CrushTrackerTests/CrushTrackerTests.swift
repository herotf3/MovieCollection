//
//  CrushTrackerTests.swift
//  CrushTrackerTests
//
//  Created by MacBook on 8/9/18.
//  Copyright © 2018 MacBook. All rights reserved.
//

import XCTest
@testable import CrushTracker

class CrushTrackerTests: XCTestCase {
    
    
    //MARK: Movie class test
    
    //Confirm that movie initializier return obj when passes valid params
    func testMovieInitializationSucceeds(){
        let zeroRatingMeal = Movie.init(name: "Zero", rating: 0, image: nil)
        XCTAssertNotNil(zeroRatingMeal)
        
        // Highest positive rating
        let positiveRatingMeal = Movie.init(name: "highest", rating: 5, image: nil)
        XCTAssertNotNil(positiveRatingMeal)
    }
    
    //confirm that movie initializer return nil with invalid params
    func testMovieInitializationFails(){
        //Negative rating
        let negativeRatingMeal = Movie.init(name: "Negative", rating: -1, image: nil)
        XCTAssertNil(negativeRatingMeal)
        // Rating exceeds maximum
        let largeRatingMeal = Movie.init(name: "Large", rating: 6, image: nil)
        XCTAssertNil(largeRatingMeal)
        // Empty String
        let emptyStringMeal = Movie.init(name: "", rating: 0, image: nil)
        XCTAssertNil(emptyStringMeal)
    }
}
