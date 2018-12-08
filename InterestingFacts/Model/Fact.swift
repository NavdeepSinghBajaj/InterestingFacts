//
//  Fact.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/7/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import Foundation


struct InterestingFacts: Decodable {
    let title: String?
    let facts: [Fact]
    
    enum CodingKeys : String, CodingKey {
        case title
        case facts = "rows"
    }
}

struct Fact: Decodable {
    let title: String?
    let detail: String?
    let imageURL: URL?
    
    enum CodingKeys : String, CodingKey {
        case title
        case detail = "description"
        case imageURL = "imageHref"
    }
}

func loadLocalJson() -> InterestingFacts? {
    if let url = Bundle.main.url(forResource: Constants.FileName.localFactJson, withExtension: Constants.FileName.jsonExtension) {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let jsonData = try decoder.decode(InterestingFacts.self, from: data)
            return jsonData
            
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}


func loadFactsJson(from url: URL?) -> InterestingFacts? {
    if let url = url {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            let jsonData = try decoder.decode(InterestingFacts.self, from: data)
            return jsonData
            
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
