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
    let estimatedCellHeight:CGFloat = 100
    var layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    var interestingFacts: InterestingFacts? {
        didSet {
            resetCollectionView()
        }
    }
    
    // MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchFactsFromServer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: estimatedCellHeight)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {[unowned self] ctx in
            self.orientationChanged()
        }, completion: { [unowned self] _ in
            self.collectionView.reloadData()
        })
        
    }
    
    
    // MARK:- Custom Methods
    
    func resetCollectionView()  {
        DispatchQueue.main.async {
            self.collectionView.setNeedsLayout()
            self.collectionView.layoutIfNeeded()
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.reloadData()
        }
    }
    
    func orientationChanged() {
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
    func setupCollectionView() {
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: estimatedCellHeight)
        
        collectionView?.dataSource = self
        collectionView?.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.factCell)
        collectionView?.collectionViewLayout = layout
        
        if interestingFacts != nil {
            resetCollectionView()
        }
    }
    
    @IBAction func refresh(_ sender: Any) {
        fetchFactsFromServer()
    }
    
    func fetchFactsFromServer() {
        if APIClient.isConnectedToInternet() {
            showProgressViewWith(message: Constants.Message.pleaseWait)
            DispatchQueue.global().async {
                APIClient.getFactsJSON {[weak self] (status, result) in
                    if status {
                        // got data
                        self?.interestingFacts = result
                        self?.title = self?.interestingFacts?.title
                        hideProgressView()
                    } else {
                        // no data
                        hideProgressView()
                        self?.alert(message: Constants.Message.somethingWentWrong, buttons: [Constants.Button.showLocalData, Constants.Button.ok], handler: { (action) in
                            if action.title == Constants.Button.showLocalData {
                                self?.interestingFacts =  loadLocalJson() 
                                self?.title = self?.interestingFacts?.title
                            }
                        })
                    }
                }
            }
        } else {
            self.alert(error: Constants.Message.noInternet)
        }
    }
    
}

// MARK: - UICollectionViewDataSource

extension HomeCollectionViewController: FactCellDelegate {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interestingFacts?.facts.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.factCell, for: indexPath) as! FactCollectionViewCell
        cell.delegate = self
        
        if let fact = interestingFacts?.facts[indexPath.row] {
            cell.loadCell(with: fact, for: collectionView)
        }
        
        return cell
    }
    
    func refreshLayout() {
        // TODO:- Need to fix crash while adjusting cells height
        
//        DispatchQueue.main.async {
//            UIView.animate(withDuration: 0.3, animations: {[weak self] in
//                collectionView.collectionViewLayout.invalidateLayout()
//            }) { _ in
//             self.collectionView.reloadData()
//            }
//        }
    }
    
}
