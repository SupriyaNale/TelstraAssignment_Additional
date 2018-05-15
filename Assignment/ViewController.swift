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
    var fetchedData = DataManager.sharedInstance.fetchedData
    
    var refreshCtrl: UIRefreshControl!
    var cache:NSCache<AnyObject, AnyObject>!
    var task: URLSessionDownloadTask!
    var session: URLSession!

    let activityView = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    let loadingView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    
    
    //MARK:- Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = Constants.Messages.title
        
        () = DataManager.sharedInstance.fetchedData.count > 0 ? () : fetch()
        tableView.estimatedRowHeight = CGFloat(Constants.MagicNumbers.rowHeight)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.separatorStyle = UITableViewCellSeparatorStyle.singleLine
        
        self.cache = NSCache()
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        drawTable()
        pullToRefresh()
    }
    
    override func viewDidLayoutSubviews() {
        drawTable()
    }
    
    //MARK:- Table View Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fetchedData.count > 0 {
            return fetchedData.count
        } else {
            return 0
        }
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
    
    //MARK:- Design Cell Method
    
    func design(indexPath: IndexPath, cell: CustomeTableViewCell) {
        self.navigationItem.title = Constants.Messages.title
        cell.titleLabel.text = (fetchedData[indexPath.row].title == "" ? "No Data Found" : fetchedData[indexPath.row].title)
        cell.descLabel.text = (fetchedData[indexPath.row].description == "" ? "No Data Found" : fetchedData[indexPath.row].description)
        
        activityView.center.x = 60
        activityView.center.y = cell.imageview.center.y
        cell.imageview.addSubview(activityView)
        activityView.startAnimating()
        cell.imageview.image = UIImage(named: "placeholder")
        cell.selectionStyle = .none
        
        downloadImage (indexPath: indexPath, cell: cell)
    }
    
    func downloadImage(indexPath: IndexPath, cell: CustomeTableViewCell) {
        
        if (cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) != nil){
            // Use cache
            print("Cached image used, no need to download it")
            activityView.stopAnimating()
            cell.imageview.image = cache.object(forKey: (indexPath as NSIndexPath).row as AnyObject) as? UIImage
        } else {
            let imageUrl = fetchedData[indexPath.row].imageURL
            
            if let url:URL = URL(string: imageUrl) {
                activityView.startAnimating()
                task = session.downloadTask(with: url, completionHandler: { (location, response, error) -> Void in
                    if let data = try? Data(contentsOf: url) {
                        DispatchQueue.main.async(execute: { () -> Void in
                            // Before we assign the image, check whether the current cell is visible
                            if let updateCell = self.tableView.cellForRow(at: indexPath) as? CustomeTableViewCell, let img:UIImage = UIImage(data: data) {
                                self.activityView.stopAnimating()
                                updateCell.imageview.image = img
                                self.cache.setObject(img, forKey: (indexPath as NSIndexPath).row as AnyObject)
                            }
                        })
                    } else {
//                        UIAlertController.show(message: "Unable to download Image")
                    }
                })
            } else {
                cell.imageview.image = UIImage(named: "placeholder")
                activityView.stopAnimating()
            }
            task?.resume()
        }
    }
    
    //MARK:- Data Methods
    func fetch() {
        loadingView.frame = CGRect(x: self.view.frame.size.width/2 - 30 , y: self.view.frame.size.height/2 - 60, width: 100, height: 100)
        loadingView.activityIndicatorViewStyle = .gray
        loadingView.startAnimating()
        tableView.addSubview(loadingView)
        
        if Reachability.isConnectedToNetwork() {
            NetworkManager.shared.fetch(completion: {_ in
                print("Executed Successfully.\(DataManager.sharedInstance.fetchedData.count)")
                DispatchQueue.main.async(execute: { () -> Void in
                    self.loadingView.stopAnimating()
                    self.fetchedData = DataManager.sharedInstance.fetchedData
                    self.tableView.reloadData()
                    self.refreshCtrl?.endRefreshing()
                })
            }, error: { message in
                DispatchQueue.main.async() {
                    self.loadingView.stopAnimating()
                }
                UIAlertController.show(message: message)
            })
        } else {
            DispatchQueue.main.async() {
                self.loadingView.stopAnimating()
                UIAlertController.show(message: "\(Constants.Messages.networkError)")
            }
        }
    }
    
    //MARK:- Pull to refresh
    func pullToRefresh() {
        self.refreshCtrl = UIRefreshControl()
        self.refreshCtrl.addTarget(self, action: #selector(fetch), for: .valueChanged)
        self.tableView.refreshControl = self.refreshCtrl
    }
}

