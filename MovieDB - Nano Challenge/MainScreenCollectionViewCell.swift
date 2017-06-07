//
//  MainScreenCollectionViewCell.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MainScreenCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet var movieImageView: UIImageView!
	
	func loadDefaultImg() {
		// só pra testes
		movieImageView.backgroundColor = UIColor.gray
		
	}
	
	func loadMovieImage(image img: UIImage) {
		
		movieImageView.image = img
	}
}
