//
//  FactCollectionViewCell.swift
//  InterestingFacts
//
//  Created by Navdeep Singh on 12/6/18.
//  Copyright © 2018 Navdeep Singh Bajaj. All rights reserved.
//

import UIKit
import SnapKit

class FactCollectionViewCell: UICollectionViewCell {
    // MARK:-
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    let lblTitle: UILabel = {
        let lblTitle = UILabel()
        lblTitle.font = UIFont.boldSystemFont(ofSize: 16)
        lblTitle.textColor = .black
        lblTitle.numberOfLines = 0
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        return lblTitle
    }()
    
    let lblDescription: UILabel = {
        let lblDescription = UILabel()
        lblDescription.font = UIFont.systemFont(ofSize: 12)
        lblDescription.textColor = .gray
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        return lblDescription
    }()
    
    let factImageView: UIImageView = {
        let factImageView = UIImageView()
        factImageView.translatesAutoresizingMaskIntoConstraints = false
        factImageView.image = UIImage(named: Constants.Image.placeHolderImage)
        return factImageView
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis  = .vertical
        verticalStackView.distribution  = .fillProportionally
        verticalStackView.alignment = .fill
        verticalStackView.spacing   = 10.0
        return verticalStackView
    }()
    
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        //contentView.backgroundColor = .red
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    
    // MARK: - Custom Methods
    func setupViews() {
        
        // adding fact image
        contentView.addSubview(factImageView)
        factImageView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.bottom.equalTo(contentView).offset(-10).priority(.high)
            make.height.equalTo(100)
            make.width.equalTo(100)
        }
        
        // Vertical Stack View
        contentView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // adding fact title
        verticalStackView.addArrangedSubview(lblTitle)
        
        // adding fact description
        verticalStackView.addArrangedSubview(lblDescription)
        
        verticalStackView.snp.makeConstraints { (make) in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(factImageView.snp.right).offset(10)
            make.bottom.equalTo(contentView).offset(-10).priority(.medium)
            make.right.equalTo(contentView).offset(-10)
        }
        
    }
    
}
