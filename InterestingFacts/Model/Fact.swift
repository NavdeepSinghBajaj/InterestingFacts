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

func loadFactsJson() -> InterestingFacts? {
    if let data = Constants.Facts.jsonString.data(using: .utf8) {
        let decoder = JSONDecoder()
        guard let jsonData = try? decoder.decode(InterestingFacts.self, from: data) else {
            print("Error: Couldn't decode data")
            return nil
        }
        return jsonData
    }
    return nil
}

func loadFactsJson(from url: URL?) -> InterestingFacts? {
    if let url = url {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            
            if let jsonData = try? decoder.decode(InterestingFacts.self, from: data) {
                return jsonData
            } else {
                print("Error: Couldn't decode data because json is curropted")
            }
            
        } catch {
            print("error:\(error)")
        }
    }
    return nil
    // returning data from saved json string, because of curropted json provided
    //return loadFactsJson()
}
