//
//  HomeViewModel.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/11/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit

class HomeViewModel {
    
    let estimatedCellHeight = CGFloat(100)
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var interestingFacts: DynamicValue<InterestingFacts>?
    
    init() {
        interestingFacts = DynamicValue(InterestingFacts())
    }

}

extension HomeViewModel {
    
    func fetchFactsFromServer(onSuccess: @escaping () -> Void, onError: @escaping (_ errorMessage: String?) -> Void) {
        if APIClient.isConnectedToInternet() {
            DispatchQueue.global().async {
                APIClient.getFactsJSON {[weak self] (status, result) in
                    if status {
                        self?.interestingFacts?.value = result!
                        onSuccess()
                    } else {
                        // no data
                        onError(Constants.Message.somethingWentWrong)
                    }
                }
            }
        } else {
            onError(Constants.Message.noInternet)
        }
    }
    
    func getFactsCount() -> Int {
        return self.interestingFacts?.value.facts?.count ?? 0
    }
}
