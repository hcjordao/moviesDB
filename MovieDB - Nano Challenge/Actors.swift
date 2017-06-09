//
//  Actors.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Actors: NSObject, NSCoding {

    var name:String
    var profilePath:String
    var role:String
    
    init(name:String, profilePath:String, role:String) {
        
        self.name = name
        self.profilePath = profilePath
        self.role = role
        super.init()
    }
    
    override init (){
       
        self.name = ""
        self.profilePath = ""
        self.role = ""
    }
    
    required init(coder decoder: NSCoder) {
        
        name = decoder.decodeObject( forKey:"actorName") as? String ?? ""
        profilePath = decoder.decodeObject( forKey:"actorProfilePath") as? String ?? ""
        role = decoder.decodeObject( forKey:"actorRole") as? String ?? ""
        
    }
    
    func encode(with coder:NSCoder){
        
        coder.encode (name, forKey:"actorName")
        coder.encode (profilePath, forKey:"actorProfilePath")
        coder.encode (role, forKey:"actorRole")
    }
    
    
    
    
}
