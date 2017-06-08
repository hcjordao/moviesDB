//
//  Images.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Images: AnyObject {

    
    var imagePath:String!
    
   init() {
        
        imagePath = ""
    }
    
    init(imagePath:String) {
        
        self.imagePath = imagePath
    }
    
//    required init(coder decoder: NSCoder) {
//        self.imagePath = decoder.decodeObject(forKey: "imagePath") as? String ?? ""
//        
//        
//        
//    }
//    
//    func encode(with coder: NSCoder) {
//        coder.encode(imagePath, forKey: "imagePath")
//        
//        
//    }
    
    
}
