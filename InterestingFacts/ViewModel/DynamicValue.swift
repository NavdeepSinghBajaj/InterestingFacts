//
//  Dynamic.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/11/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import Foundation

class DynamicValue<T> {
    typealias Listener = (T) -> Void
    var listener: Listener?
    
    func bind(_ listener: Listener?) {
        self.listener = listener
    }
    
    func bindAndFire(_ listener: Listener?) {
        self.listener = listener
        listener?(value)
    }
    
    var value: T {
        didSet {
            listener?(value)
        }
    }
    
    init(_ v: T) {
        value = v
    }
}
