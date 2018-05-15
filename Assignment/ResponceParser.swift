//
//  ResponceParser.swift
//  Assignment
//
//  Created by Yash on 14/05/18.
//  Copyright © 2018 infosys. All rights reserved.
//

import Foundation

class ResponseParser {
    
    //MARK:- Parser Methods
    
    class func imagesFromJSON(_ json: [[String: AnyObject]]) -> [DataModel] {
        var images = [DataModel]()
        for image in json {
            do {
                images.append(try DataModel(json: image))
            }
            catch DataModelError.dataIDEmpty {
                print("imageIDEmpty")
            }
            catch {}
        }
        return images
    }
    
}
