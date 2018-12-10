//
//  AppDelegate.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        openHomeViewController()
        
        return true
    }
    
    func openHomeViewController()   {
        navController = UINavigationController()
        navController?.navigationBar.barTintColor = Constants.AppColor.blue
        navController?.navigationBar.tintColor = .white
        
        let titleDict: NSDictionary = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navController?.navigationBar.titleTextAttributes = titleDict as? [NSAttributedString.Key : Any]

        
        let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        let homeVC = HomeCollectionViewController.init(collectionViewLayout: layout)
        homeVC.collectionView.backgroundColor = Constants.AppColor.offWhite
        self.navController?.viewControllers = [homeVC]
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navController
        self.window?.backgroundColor = .black
        self.window?.makeKeyAndVisible()
        
    }
    
}

