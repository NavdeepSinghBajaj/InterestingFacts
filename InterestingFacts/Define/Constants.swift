//
//  Constants.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit

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
    
    struct AppColor {
        static let blue = UIColor(red: 53.0/255.0, green: 137.0/255.0, blue: 185.0/255.0, alpha: 1.0)
        static let offWhite = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 239.0/255.0, alpha: 1.0)
    }
    
    struct Button {
        static let ok = "OK"
        static let cancel = "Cancel"
        static let retry = "Retry"
        static let showLocalData = "Show Local Data"
    }
    
    struct Message {
        static let noInternet = "Internet not available, please try again later."
        static let noData = "No information available."
        static let somethingWentWrong = "Something went wrong while parsing json file downloaded from server. Please try again or show data from local json file."
        static let pleaseWait = "Fetching data..."
    }
    
}
