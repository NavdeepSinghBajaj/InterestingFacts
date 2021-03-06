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
    let facts: [Fact]?
    
    enum CodingKeys : String, CodingKey {
        case title
        case facts = "rows"
    }
    
    init() {
        title = nil
        facts = nil
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
    
    init() {
        title = nil
        detail = nil
        imageURL = nil
    }
}

func loadLocalJson(from url: URL?) -> InterestingFacts? {
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


func loadFactsJson(from url: URL?) -> InterestingFacts? {
    if let url = url {
        do {
            let data = try Data(contentsOf: url)
            let stringValue = String(data: data, encoding: .ascii)
            if let errorFreeData = stringValue?.data(using: String.Encoding.utf8) {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(InterestingFacts.self, from: errorFreeData)
                return jsonData
            }
        } catch {
            print("error:\(error)")
        }
    }
    return nil
}
