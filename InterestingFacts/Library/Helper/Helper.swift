//
//  Helper.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import Foundation
import SVProgressHUD


// MARK: - Progress Hud
private func setupProgressView() {
    SVProgressHUD.setDefaultStyle(.light)
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.setMinimumDismissTimeInterval(2.0)
}

func showProgressView() {
    setupProgressView()
    DispatchQueue.main.async {
        SVProgressHUD.show()
    }
}

func showProgressViewWith(message: String) {
    DispatchQueue.main.async {
        SVProgressHUD.show(withStatus: message)
    }
}

func hideProgressView() {
    DispatchQueue.main.async {
        SVProgressHUD.dismiss()
    }
}

func showSuccess(_ message: String?) {
    DispatchQueue.main.async {
        SVProgressHUD.showSuccess(withStatus: message)
    }
}

func showError(_ message: String?) {
    DispatchQueue.main.async {
        SVProgressHUD.showError(withStatus: message)
    }
}

// MARK: - Get storyboard
func getMainStoryboard() -> UIStoryboard {
    let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    return storyBoard
}


// MARK: -
func getSavedJsonURL() -> URL {
    var documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    documentsURL.appendPathComponent(Constants.FileName.factsJSON)
    return documentsURL
}
