//
//  ViewController.swift
//  Assignment
//
//  Created by Yash on 11/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK:- Properties
    var tableView: UITableView = UITableView()
    var headerView: UIView = UIView()
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.title = "DATA"
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        drawTable()
    }
    
    override func viewDidLayoutSubviews() {
        drawTable()
    }
    
    //MARK:- Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? CustomeTableViewCell {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            design(indexPath: indexPath, cell: cell)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    //MARK:- Table View Delegate Method
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    /*
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerlabel = UILabel()
        headerlabel.text = "Title"//Constants.Messages.title
        headerlabel.textAlignment = .center
        headerlabel.font = UIFont.preferredFont(forTextStyle: .headline)
        headerlabel.frame = CGRect(x: self.headerView.center.x - 50 , y: 10, width: self.headerView.frame.size.width, height: 20.0)
        headerlabel.backgroundColor = UIColor.white
        return headerlabel
    }
    */
    

    //MARK:- UI Related Methods
    func drawTable() {
        //Table View
        
        tableView.frame = CGRect(x: 0, y: 60, width: self.view.frame.size.width, height: self.view.frame.size.height - 60)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        
        tableView.register(CustomeTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        self.view.addSubview(tableView)
        self.view.addSubview(headerView)
        
    }
    
    //TODO:- Pull to refresh
    
    //MARK:- Design Cell Method
    func design(indexPath: IndexPath, cell: CustomeTableViewCell) {
        cell.titleLabel.text = "data Title"
        cell.descLabel.text =  "Data"
        
        cell.imageview.image = UIImage(named: "placeholder")
        cell.selectionStyle = .none
    }
}

