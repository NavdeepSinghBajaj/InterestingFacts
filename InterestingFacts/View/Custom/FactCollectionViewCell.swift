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
        lblDescription.textColor = .darkGray
        lblDescription.numberOfLines = 0
        lblDescription.translatesAutoresizingMaskIntoConstraints = false
        return lblDescription
    }()
    
    let factImageView: UIImageView = {
        let factImageView = UIImageView()
        factImageView.translatesAutoresizingMaskIntoConstraints = false
        factImageView.contentMode = .scaleAspectFit
        factImageView.backgroundColor = .black
        return factImageView
    }()
    
    let verticalStackView: UIStackView = {
        let verticalStackView = UIStackView()
        verticalStackView.axis  = .vertical
        verticalStackView.distribution  = .fillProportionally
        verticalStackView.alignment = .fill
        verticalStackView.spacing   = 10.0
        verticalStackView.clipsToBounds = true
        return verticalStackView
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    
    // MARK: -
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.lblTitle.text = ""
        self.lblDescription.text = ""
        self.factImageView.image = nil
    }
    
    // MARK: - Custom Methods
    
    func setupCell() {
        
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        
        //  card view
        contentView.addSubview(cardView)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        cardView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(contentView.safeAreaLayoutGuide).offset(10)
                make.left.equalTo(contentView.safeAreaLayoutGuide).offset(10)
                make.bottom.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
                make.right.equalTo(contentView.safeAreaLayoutGuide).offset(-10)
            } else {
                make.top.equalTo(contentView).offset(10)
                make.left.equalTo(contentView).offset(10)
                make.bottom.equalTo(contentView).offset(-10)
                make.right.equalTo(contentView).offset(-10)
            }
        }
        
        // Vertical Stack View
        cardView.addSubview(verticalStackView)
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        // adding fact image
        verticalStackView.addArrangedSubview(factImageView)
        
        // adding fact title
        verticalStackView.addArrangedSubview(lblTitle)
        
        // adding fact description
        verticalStackView.addArrangedSubview(lblDescription)
        
        verticalStackView.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.top.equalTo(cardView.safeAreaLayoutGuide).offset(10)
                make.left.equalTo(cardView.safeAreaLayoutGuide).offset(10)
                make.bottom.equalTo(cardView.safeAreaLayoutGuide).offset(-10)
                make.right.equalTo(cardView.safeAreaLayoutGuide).offset(-10)
            } else {
                make.top.equalTo(cardView).offset(10)
                make.left.equalTo(cardView).offset(10)
                make.bottom.equalTo(cardView).offset(-10)
                make.right.equalTo(cardView).offset(-10)
            }
        }
    }
    
    func loadCell( with fact:Fact) {
        
        if let title = fact.title {
            self.lblTitle.text = title
        } else {
            self.lblTitle.text = ""
        }
        
        if let details = fact.detail {
            self.lblDescription.text = details
        } else {
            self.lblDescription.text = ""
        }
        
        if let imageUrl = fact.imageURL {
            self.factImageView.sd_setImage(with: imageUrl)
        } else {
            self.factImageView.image = nil
        }
        
        self.contentView.layoutIfNeeded()
        self.contentView.layoutSubviews()
        self.contentView.setNeedsDisplay()
        self.setNeedsDisplay()
        
    }
    
}
