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
	
    func loadCell (cellMovie: Movie) {
		
		clockAsset.image = UIImage(named: "clock")
		movieBannerImage.backgroundColor = UIColor.gray
        movieTitleLabel.text = cellMovie.originalTitle
        
        if String(cellMovie.releaseDate) != nil{
            let year: String = cellMovie.releaseDate.components(separatedBy: "-")[0]
            DispatchQueue.main.async {
                self.movieYearLabel.text = "("+year+")"
            }
        }
        
        if (cellMovie.director) != nil{
            
            DispatchQueue.main.async {
             
                self.directorNameLabel.text = cellMovie.director
                
                
            }
        }
        
        
        if (cellMovie.duration) != nil{
            
            DispatchQueue.main.async {
                // Update UI
                
                self.movieDurationLabel.text = String (cellMovie.duration / 60)+"h"+String(cellMovie.duration%60)+"m"
                
            }
        }
        
        if let url = URL(string: "http://image.tmdb.org/t/p/original/" + (cellMovie.backDropPath)){
            
            
            //print(url)
            
            if let data =  NSData(contentsOf: url){
                
                DispatchQueue.main.async {
                    
                    self.movieBannerImage.image = UIImage(data:data as Data)
                    
                }
            }
        }
        
        
	}
    
}
