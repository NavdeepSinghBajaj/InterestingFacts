//
//  Constants.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import Foundation

struct Constants {
    
    struct FileServer {
        static let fileURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }
    
    struct FileName {
        static let factsJSON = "facts.json"
        static let localFactJson = "facts_sample"
        static let jsonExtension = "json"
    }
    
    struct CollectionViewCell {
        static let factCell = "FactCollectionViewCell"
    }
    
    struct Image {
        static let placeHolderImage = "placeholder"
    }
    
    struct Button {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let retry = "Retry"
        static let showLocalData = "Show Local Data"
    }
    
    struct Message {
        static let noInternet = "Internet not available, please try again later."
        static let noData = "No Data"
        static let somethingWentWrong = "Something went wrong while parsing json file downloaded from server. Please try again or show data from local json file."
        static let pleaseWait = "Fetching data..."
    }
    
}
