//
//  CollectionViewCell.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var testLabel: UILabel!
    
    
    
    
    
    
    func initWithContent(teste: String){
        testLabel.text = teste
        
        
        
    }
}
