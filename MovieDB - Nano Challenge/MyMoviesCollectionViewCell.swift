//
//  MyMoviesCollectionViewCell.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 07/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MyMoviesCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet var movieBannerImage: UIImageView!
	
	@IBOutlet var movieYearLabel: UILabel!
	@IBOutlet var movieTitleLabel: UILabel!
	@IBOutlet var directorNameLabel: UILabel!
	
	@IBOutlet var movieDurationLabel: UILabel!
	@IBOutlet var clockAsset: UIImageView!
	
	func loadCell () {
		
		clockAsset.image = UIImage(named: "clock")
		movieBannerImage.backgroundColor = UIColor.gray
	}
    
}
