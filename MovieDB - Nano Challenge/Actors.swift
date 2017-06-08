//
//  Actors.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Actors: AnyObject {

    var name:String
    var profilePath:String
    var role:String
    
    init(name:String, profilePath:String, role:String) {
        self.name = name
        self.profilePath = profilePath
        self.role = role
    }
    
    
}
