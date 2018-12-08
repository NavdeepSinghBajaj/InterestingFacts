//
//  APIClient.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/7/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import Alamofire


class APIClient {
    
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    private static func performDownload(for url:URL, filename:String, completion: @escaping ((Bool, URL?) -> Void))  {
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            documentsURL.appendPathComponent(filename)
            return (documentsURL, [.removePreviousFile])
        }
        
        Alamofire.download(url, to: destination).responseData { response in
            if response.error != nil {
                completion(false, nil)
            }
            
            if let destinationUrl = response.destinationURL {
                completion(true, destinationUrl)
            }
        }
    }
    
    static func getFactsJSON(completion: @escaping ((Bool, InterestingFacts?) -> Void)) {
        if let fileURL = try? Constants.FileServer.fileURL.asURL() {
            performDownload(for: fileURL, filename: Constants.FileName.factsJSON) { (status, destinationFileURL) in
                if status {
                    if let interestingFacts = loadFactsJson(from: destinationFileURL) {
                        print(interestingFacts)
                        completion(true,interestingFacts)
                    } else {
                        completion(false,nil)
                    }
                } else {
                    completion(false,nil)
                }
            }
        }
    }

    
    
}
