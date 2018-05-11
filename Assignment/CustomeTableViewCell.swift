//
//  CustomeTableViewCell.swift
//  Assignment
//
//  Created by Yash on 11/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit

class CustomeTableViewCell: UITableViewCell {

    //MARK:- Properties
    let imageview = UIImageView()
    let titleLabel = UILabel()
    let descLabel = UILabel()
    
    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    //MARK:- Init
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addFontStyles()
        addSubviews()
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Design Methods
    func addFontStyles() {
        imageview.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        descLabel.translatesAutoresizingMaskIntoConstraints = false
        
        descLabel.numberOfLines = 0
        descLabel.lineBreakMode = .byWordWrapping
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        descLabel.font = UIFont (name: "Helvetica Neue", size: 15)
        descLabel.tintColor = UIColor.lightGray
    }
    
    func addSubviews() {
        contentView.addSubview(imageview)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descLabel)
    }
    
    func addConstraints() {
        let viewsDict = [
            "image" : imageview,
            "title" : titleLabel,
            "desc" : descLabel
            ] as [String : Any]
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[image(150)]-(>=11)-|", options: [], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-11-[title(20)]-[desc]-(>=10)-|", options: [.alignAllLeading], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[image(120)]-[title]-16-|", options: [.alignAllTop], metrics: nil, views: viewsDict))
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-16-[image(120)]-[desc]-16-|", options: [], metrics: nil, views: viewsDict))
    }

}
