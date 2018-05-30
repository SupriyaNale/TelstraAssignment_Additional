//
//  CustomeTableViewCell.swift
//  Assignment
//
//  Created by Yash on 11/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit
import Masonry

let kZeroPadding = UIEdgeInsetsMake(0, 0, 0, 0)
let kPadding = UIEdgeInsetsMake(10, 10, 10, 10)
let screenSize: CGRect = UIScreen.main.bounds

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
        addConstraintsToViews()
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
        descLabel.sizeToFit()
        descLabel.textAlignment = NSTextAlignment.left
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

    
    func addConstraintsToViews() {
        imageview.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.equalTo()(contentView.mas_left)?.with().setInsets(kPadding)
            make?.top.equalTo()(contentView.mas_top)?.with().setInsets(kPadding)
            make?.width.mas_equalTo()(120)?.with().setInsets(kPadding)
            make?.height.mas_equalTo()(150)?.with().setInsets(kPadding)
        }
        
        titleLabel.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.equalTo()(imageview.mas_right)?.with().setInsets(kPadding)
            make?.top.equalTo()(imageview.mas_top)?.with().setInsets(kPadding)
            make?.height.mas_equalTo()(20)?.with().setInsets(kPadding)
        }
        
        descLabel.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.left.equalTo()(imageview.mas_right)?.with().setInsets(kPadding)
            make?.top.equalTo()(titleLabel.mas_bottom)?.with().setInsets(kPadding)
            //            make?.height.mas_equalTo()(170)?.with().setInsets(kPadding)
            make?.bottom.equalTo()(contentView.mas_bottom)?.with().setInsets(kPadding)
            make?.right.equalTo()(contentView.mas_right)?.with().setInsets(kPadding)
            
        }
        contentView.mas_makeConstraints { (make: MASConstraintMaker?) in
            make?.top.left().equalTo()(0)?.with().setInsets(kZeroPadding)
            make?.width.equalTo()(screenSize.width)?.with().setInsets(kZeroPadding)
            make?.height.mas_equalTo()(150)?.with().setInsets(kZeroPadding)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // for multiline UILabel's you need set the preferredMaxLayoutWidth
        // you need to do this after [super layoutSubviews] as the frames will have a value from Auto Layout at this point
        
        // stay tuned for new easier way todo this coming soon to Masonry
        var width = imageview.frame.minX - kPadding.left - kPadding.right
        width -= descLabel.frame.minX
        descLabel.preferredMaxLayoutWidth = width;
        
        // need to layoutSubviews again as frames need to recalculated with preferredLayoutWidth
        super.layoutSubviews();
    }
}


extension String {
    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.height)
    }
    
    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        
        return ceil(boundingBox.width)
    }
}
