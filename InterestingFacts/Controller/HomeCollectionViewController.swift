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
    
    fileprivate var homeViewModel: HomeViewModel = HomeViewModel()
    
    
    // MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        fillUI()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        homeViewModel.layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: homeViewModel.estimatedCellHeight)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: {[unowned self] ctx in
            self.orientationChanged()
            }, completion: {  _ in })
    }
    
    
    // MARK:- Custom Methods

    func fillUI()  {
        homeViewModel.interestingFacts?.bindAndFire({[weak self] (interestingFacts) in
            self?.title = interestingFacts.title
            self?.reloadCollectionView()
        })
    }
    
    func reloadCollectionView()  {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
    func orientationChanged() {
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
            self.collectionView.layoutSubviews()
            self.view.layoutIfNeeded()
        }
    }
    
    func setupUI() {
        let btnRefresh =  UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refresh(_:)))
        self.navigationItem.rightBarButtonItem = btnRefresh
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let width = UIScreen.main.bounds.size.width
        homeViewModel.layout.estimatedItemSize = CGSize(width: width, height: homeViewModel.estimatedCellHeight)
        
        collectionView?.dataSource = self
        collectionView?.register(FactCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CollectionViewCell.factCell)
        collectionView?.collectionViewLayout = homeViewModel.layout
        
    }
    
    func fetchData() {
        showProgressViewWith(message: Constants.Message.pleaseWait)
        homeViewModel.fetchFactsFromServer(onSuccess: {
            hideProgressView()
        }) { [weak self] (errorMessage) in
            hideProgressView()
            self?.alert(error: errorMessage ?? "")
        }
    }
    
    @objc func refresh(_ sender: Any) {
        fetchData()
    }
    
}

// MARK: - UICollectionViewDataSource

extension HomeCollectionViewController: FactCellDelegate, UICollectionViewDelegateFlowLayout {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (homeViewModel.getFactsCount() == 0) {
            collectionView.setEmptyMessage(Constants.Message.nothingToShow)
        } else {
            collectionView.restore()
        }
        return homeViewModel.getFactsCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CollectionViewCell.factCell, for: indexPath) as! FactCollectionViewCell
        cell.delegate = self
        
        if let fact = homeViewModel.interestingFacts?.value.facts![indexPath.row] {
            cell.loadCell(with: fact)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let fact = homeViewModel.interestingFacts?.value.facts![indexPath.row] {
            let sizingCell = FactCollectionViewCell.sizingCell
            sizingCell.prepareForReuse()
            sizingCell.loadCell(with: fact)
            sizingCell.setNeedsLayout()
            sizingCell.layoutIfNeeded()
            
            var size = sizingCell.contentView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize, withHorizontalFittingPriority: UILayoutPriority.defaultHigh, verticalFittingPriority: UILayoutPriority.defaultLow)
            
            size.width = UIScreen.main.bounds.size.width
            return size
        }
        return CGSize.zero
    }
    
    func refreshLayout() {
        DispatchQueue.main.async {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    
}
