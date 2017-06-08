//
//  CollectionViewCell.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    

    
    @IBOutlet weak var movieYear: UILabel!
    
    
    @IBOutlet weak var movieTitleEn: UILabel!
    
    @IBOutlet weak var movieDuration: UILabel!
    
    @IBOutlet weak var movieImage: UIImageView!
    
    
    @IBOutlet weak var movieDirector: UILabel!
    
    
    
    
    func initWithContent(cellMovie: Movie){
        
        
        
        let request = RequestsManager()
        
        //var duration:Int!
        
        if String(cellMovie.releaseDate) != nil{
            let year: String = cellMovie.releaseDate.components(separatedBy: "-")[0]
            DispatchQueue.main.async {
                self.movieYear.text = "("+year+")"
            }
        }
        
        request.getMovieInformationByMovieId(movieID: cellMovie.id) { (movieInfo) in
            
            
            if (movieInfo.director) != nil{
                
                DispatchQueue.main.async {
                    // Update U
                
                self.movieDirector.text = movieInfo.director
                self.movieDirector.font = UIFont.italicSystemFont(ofSize: 18.0)
                
                }
            }
            
            
            if let duration = movieInfo.duration{
                
                DispatchQueue.main.async {
                    // Update UI
                
                self.movieDuration.text = String (duration / 60)+"h"+String(duration%60)+"min"
                    
                }
            }
           
        }
       
        if let url = URL(string: "http://image.tmdb.org/t/p/original/" + (cellMovie.backDropPath)){
            
            
            print(url)
            
            if let data =  NSData(contentsOf: url){
                
                DispatchQueue.main.async {
                    
                self.movieImage.image = UIImage(data:data as Data)
                    
                }
            }
        }

        
        movieTitleEn.text = cellMovie.originalTitle

    }
}
