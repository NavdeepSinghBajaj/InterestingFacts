//
//  FactTests.swift
//  InterestingFactsTests
//
//  Created by Navdeep Singh on 12/8/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import XCTest
@testable import InterestingFacts

class FactTests: XCTestCase {
    
    var testBundle: Bundle!
    
    override func setUp() {
        super.setUp()
        testBundle = Bundle(for: type(of: self))
    }
    
    override func tearDown() {
        testBundle = nil
    }
    
    func testLoadJsonFromLocalPath() {
        // 1. Given
        let localJsonUrl = testBundle.url(forResource: TestConstants.FileName.localFactJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(localJsonUrl)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: localJsonUrl)
        
        // 3. Then
        XCTAssertNotNil(testInterestingFacts)
    }
    
    func testParseValidJson() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.validJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        
        // 3. Then
        XCTAssertNotNil(testInterestingFacts)
    }
    
    func testParseInvalidJson() {
        // 1. Given
        let invalidJsonURL = testBundle.url(forResource: TestConstants.FileName.invalidJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(invalidJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: invalidJsonURL)
        
        // 3. Then
        XCTAssertNil(testInterestingFacts)
    }
    
    
    func testValidJsonForRootTitle() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.validJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        XCTAssertNotNil(testInterestingFacts)
        
        // 3. Then
        XCTAssertTrue((testInterestingFacts?.title == "About Canada"))
    }
    
    func testValidJsonForRootNoTitle() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.noRootTitleJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        XCTAssertNotNil(testInterestingFacts)
        
        // 3. Then
        XCTAssertNil(testInterestingFacts?.title)
    }
    
    func testValidJsonForFactData() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.validJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        XCTAssertNotNil(testInterestingFacts)
        
        // 3. Then
        let fact = testInterestingFacts?.facts?.first!
        XCTAssertNotNil(fact)
        XCTAssertTrue((fact?.title == "Beavers"))
        XCTAssertTrue((fact?.detail == "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony"))
        XCTAssertTrue((fact?.imageURL == URL(string: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg") ))
    }
    
    func testValidJsonForFactNoData() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.noFactDataJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        XCTAssertNotNil(testInterestingFacts)
        
        // 3. Then
        let fact = testInterestingFacts?.facts?.first!
        XCTAssertNotNil(fact)
        XCTAssertNil(fact?.title)
        XCTAssertNil(fact?.detail)
        XCTAssertNil(fact?.imageURL)
    }
    
    func testValidJsonForNoFacts() {
        // 1. Given
        let validJsonURL = testBundle.url(forResource: TestConstants.FileName.noFactsJson, withExtension: TestConstants.FileName.jsonExtension)
        XCTAssertNotNil(validJsonURL)
        
        // 2. When
        let testInterestingFacts = loadLocalJson(from: validJsonURL)
        XCTAssertNotNil(testInterestingFacts)
        
        // 3. Then
        XCTAssertNil(testInterestingFacts?.facts)
    }
    
    
}
