//
//  HomeViewController.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit
import SDWebImage

class HomeCollectionViewController: UICollectionViewController {
    // MARK:-
    let estimatedCellHeight:CGFloat = 10
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var interestingFacts: InterestingFacts? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFactsFromServer()
        setupLayout()
        setupCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: estimatedCellHeight)
        layout.invalidateLayout()
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
        
        if interestingFacts != nil {
            collectionView.reloadData()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        fetchFactsFromServer()
    }
    
    func fetchFactsFromServer() {
        if APIClient.isConnectedToInternet() {
            showProgressView()
            DispatchQueue.global().async {
                APIClient.getFactsJSON {[weak self] (status, result) in
                    hideProgressView()
                    if status {
                       // got data
                        self?.interestingFacts = result
                        self?.title = self?.interestingFacts?.title
                    } else {
                        // no data
                        self?.alert(error: Constants.Messages.somethingWentWrong)
                    }
                }
            }
        } else {
            self.alert(error: Constants.Messages.noInternet)
        }
    }
    
    // MARK: - UICollectionViewDataSource
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestingFacts?.facts.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.factCell, for: indexPath) as! FactCollectionViewCell
        
        if let fact = interestingFacts?.facts[indexPath.row] {
            cell.loadCell(with: fact)
        }
        cell.layoutIfNeeded()
        cell.layoutSubviews()
        return cell
    }
    
    
    
}
