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
    
    var validJson: String!
    
    override func setUp() {
        super.setUp()
        validJson = """
        {
        "title": "About Canada",
        "rows": [
        {
        "title": "Beavers",
        "description": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
        "imageHref": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        }]
        }
        """
    }
    
    override func tearDown() {
        validJson = nil
    }
    
    func testLoadJsonFromLocalPath() {
        // 1. Given
        let localJsonUrl = Bundle.main.url(forResource: Constants.FileName.localFactJson, withExtension: Constants.FileName.jsonExtension)
        
        // 2. When
        let testInterestingFacts = loadFactsJson(from: localJsonUrl)
        
        // 3. Then
        XCTAssertNotNil(testInterestingFacts)
    }
    
    func testParseValidJson() {
        // 1. Given
        let validJsonString = self.validJson!
        
        // 2. When
        let data = validJsonString.data(using: .utf8)!
        let testInterestingFacts = try? JSONDecoder().decode(InterestingFacts.self, from: data)
        
        // 3. Then
        XCTAssertNotNil(testInterestingFacts)
    }
    
    func testValidJsonForRootTitle() {
        // 1. Given
        let validJsonString = self.validJson!
        
        let data = validJsonString.data(using: .utf8)!
        // 2. When
        let testInterestingFacts = try? JSONDecoder().decode(InterestingFacts.self, from: data)
        
        // 3. Then
        XCTAssertTrue((testInterestingFacts?.title == "About Canada"))
    }
    
    func testValidJsonForFactTitle() {
        // 1. Given
        let validJsonString = self.validJson!
        
        // 2. When
        let data = validJsonString.data(using: .utf8)!
        let testInterestingFacts = try? JSONDecoder().decode(InterestingFacts.self, from: data)
        
        // 3. Then
        let fact = testInterestingFacts?.facts.first!
        XCTAssertTrue((fact?.title == "Beavers"))
        
    }
    
    func testParseInValidJson() {
        // 1. Given
        let invalidJson = """
        {
        "Heading": "About Canada",
        "facts": [
        {
        "label": "Beavers",
        "desc": "Beavers are second only to humans in their ability to manipulate and change their environment. They can measure up to 1.3 metres long. A group of beavers is called a colony",
        "image": "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg"
        }
        }
        """
        
        // 2. When
        let data = invalidJson.data(using: .utf8)!
        let testInterestingFacts = try? JSONDecoder().decode(InterestingFacts.self, from: data)
        
        // 3. Then
        XCTAssertNil(testInterestingFacts)
        
    }
    
    
    
}
