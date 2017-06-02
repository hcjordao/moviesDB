//
//  MovieModel.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MovieModel: AnyObject {

    var movieArray: [Movie] = []
    
    
    
    func initWithMovie (Movie: Movie)
    {
        
        movieArray.append(Movie)
        
    }
    
}
