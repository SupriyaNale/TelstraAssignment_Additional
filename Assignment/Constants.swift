//
//  Constants.swift
//  Assignment
//
//  Created by Yash on 14/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation

//Defining all constants

struct Constants {
    
    //Define Network related contacts (Base URL)
    struct URL {
        fileprivate static let baseURL = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        
        static var path: Foundation.URL? {
            if let pathURL = Foundation.URL(string: URL.baseURL) {
                return pathURL
            }
            return nil
        }
    }
    
    //Define blocks
    struct Blocks {
        typealias Error = (String) -> Void
        typealias Completion = (Bool) -> Void
        typealias NetworkResponseDictionary = ([String: AnyObject]) -> Void
    }
    
    struct MagicNumbers {
        static let rowHeight = 200.0
    }
    
    //Define status messages    
    struct Messages {
        static let unexpectedError = "Sorry! Unexpected error"
        static var title = "Title"
        static let networkError = "No Network Found!"
    }
}
