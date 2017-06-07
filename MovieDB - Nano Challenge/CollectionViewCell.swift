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
        
        request.getMovieInformationByMovieId(movieID: cellMovie.id) { (movieInfo) in
            
            
            if (movieInfo.director) != nil{
                self.movieDirector.text = movieInfo.director
            }
            
            
            if let duration = movieInfo.duration{
                self.movieDuration.text = String(duration)
            }
            
            
            
            
            
//            
//            if let movieImages = movieInfo.movieImages{
//                
//                
//                for paths in movieImages{
//                    if let url = URL(string: "http://image.tmdb.org/t/p/w375/\(paths.imagePath)"){
//                                        if let data =  NSData(contentsOf: url){
//                                            self.movieImage.image = UIImage.init(data: data as Data)
//                                        }
//                                    }
//                    
//                }
//                
//               
//                    
//                    
//                    
//                }
//            
//            else 
//                
//            }
            
            
            
            
            
            
        }
        if let url = URL(string: "http://image.tmdb.org/t/p/original/\(cellMovie.backDropPath)"){
                                                    if let data =  NSData(contentsOf: url){
                                                        self.movieImage.image = UIImage.init(data: data as Data)
                                                    }
                                                }

        
     
        
        
        
        
        
//        if (cellMovie.posterPath != ""){
//            
//            
////            NSString *filePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"imageName"] ofType:@"jpg"];
////            UIImage *theImage = [UIImage imageWithContentsOfFile:filePath];
//            if let url = URL(string: cellMovie.posterPath){
//                if let data =  NSData(contentsOf: url){
//                    movieImage.image = UIImage.init(data: data as Data)
//                }
//            }
//            
//            
//        }
//        
        
        
        //movieYear.text = String.init(format: "(" + cellMovie.year + ")")
        movieTitleEn.text = cellMovie.originalTitle
        
        
    
        
        //movieTitlePort.text = cellMovie.
        //movieDuration.text = String(cellMovie.duration)
        
    }
}
