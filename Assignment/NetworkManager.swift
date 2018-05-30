//
//  NetworkManager.swift
//  Assignment
//
//  Created by Yash on 14/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation
import UIKit
import AFNetworking

class NetworkManager: NSObject {
    /**
     You obtain the global instance from a singleton class through a factory method.
     */
    //MARK:- Properties
    static let shared = NetworkManager()
    var data = DataManager.sharedInstance.fetchedData    
    let manager = AFHTTPSessionManager()
    
    /**
     fetch(for:completion:error:) will fetch response data. URL will be supplied from Constants.URL structure.
     
     - parameters:
     - for: A url to fetch the data.
     - completion: Handle the fetched list. Output will be a [String : AnyObject]
     - error: Handle errors which may come from API.
     */
    
    //MARK:- Network Methods
    func fetch(completion: @escaping Constants.Blocks.Completion, error: @escaping Constants.Blocks.Error) {
        guard let url = Constants.URL.path else {
            completion(false)
            return
        }
        GET(url, completion: { (json) in
            if let data = json as? [String: Any], let imageData = data["rows"] as? [[String: AnyObject]], let titleData = data["title"]  {
                self.data = ResponseParser.imagesFromJSON(imageData)
                DataManager.sharedInstance.fetchedData = self.data
                Constants.Messages.title = titleData as! String
                completion(true)
            }
        }) { (error) in
            completion(false)
        }
    }
    
    /**
     Privately used by NetworkManager for generate a get request for the given url.
     
     - parameters:
     - url: URL instance of image url.
     - completion: Handle the fetched data.
     - error: Handle errors which may come from API.
     */
    fileprivate func GET(_ url: URL, completion: @escaping (Any) -> Void, error errorBlock: Constants.Blocks.Error?) {
        print(url)
        
        manager.requestSerializer = AFHTTPRequestSerializer()
        manager.responseSerializer = AFHTTPResponseSerializer()
        manager.responseSerializer.acceptableContentTypes = NSSet.init(object: "text/plain") as? Set<String>
        
        manager.get(url.absoluteString, parameters: nil, progress:{ (Progress) in
            print("In Progress")
        }, success: { (task, responseObject) in
            let responseStrInISOLatin = String(data: responseObject as! Data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let responseJSONDict = try JSONSerialization.jsonObject(with: modifiedDataInUTF8Format )
//                print("responseJSONDict : ", responseJSONDict)
                completion(responseJSONDict)
            } catch {
                print(error)
            }
        }, failure: { (task, error) in
            print("ERROR : ", error)
        })
    }
}



