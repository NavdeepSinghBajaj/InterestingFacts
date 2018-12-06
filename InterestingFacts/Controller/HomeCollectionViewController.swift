//
//  HomeViewController.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit

class HomeCollectionViewController: UICollectionViewController {
    // MARK:-
    let estimatedCellHeight:CGFloat = 10
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    
    // MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupLayout()
        setupCollectionView()
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: estimatedCellHeight)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: estimatedCellHeight)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    
    
    // MARK:- Custom Methods
    
    func setupLayout() {
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: estimatedCellHeight)
    }
    
    func setupCollectionView() {
        
        collectionView?.dataSource = self
        collectionView?.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.factCell)
        collectionView?.collectionViewLayout = layout
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.factCell, for: indexPath) as! FactCollectionViewCell
        
        cell.lblTitle.text = "Lorem ipsum"
        
        cell.lblDescription.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        
        return cell
    }
    
    
    
}
