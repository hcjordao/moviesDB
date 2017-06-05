//
//  CollectionViewCell.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var movieTitlePort: UILabel!
    
    @IBOutlet weak var movieYear: UILabel!
    
    
    @IBOutlet weak var movieTitleEn: UILabel!
    
    @IBOutlet weak var movieDuration: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    
    
    
    
    func initWithContent(cellMovie: Movie){
        movieYear.text = String.init(format: "(" + cellMovie.year + ")")
        movieTitleEn.text = cellMovie.originalTitle
        //movieTitlePort.text = cellMovie.
        movieDuration.text = String(cellMovie.duration)
        
    }
}
