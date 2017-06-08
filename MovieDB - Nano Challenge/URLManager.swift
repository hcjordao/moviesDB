//
//  URLManager.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit


class URLManager: AnyObject {

    
    
    // Talvez nao seja utilizada
    
    func getMovieCastUrlFromMovieId(movieID:Int)->URL{

        return URL(string: "http://api.themoviedb.org/3/movie/\(movieID)/casts?api_key=f0e3c4fcec46612abd4acf735d09c4a6")!
        
    }
    
    func getCurrentMoviesInTheaterUrl()->URL{
        
        return URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=f0e3c4fcec46612abd4acf735d09c4a6&language=en-US")!
        
    }
    
    func getMoviesUrlSearchForMovieName(movieName:String)->URL{
        
        
        var movieNameS = movieName.replacingOccurrences(of:" ", with: "%20")
        
        return URL(string: "http://api.themoviedb.org/3/search/movie?api_key=f0e3c4fcec46612abd4acf735d09c4a6&query=" + (movieNameS) + "&sort_by=original_title.asc")!
   
    
    }
    
    func getMovieInformationURLFromMovieID(movieID:Int)->URL{
     
        return URL(string: "https://api.themoviedb.org/3/movie/\(movieID)?api_key=f0e3c4fcec46612abd4acf735d09c4a6&append_to_response=videos,images,casts")!
        
    }
    
    func getImageDataUrlFromSemiPathAndSize(semiPath:String, size:Int)->URL{
        
        if(size>0){
         
            return URL(string: "https://image.tmdb.org/t/p/original\(semiPath)")!
            
        }
        else{
            
            return URL(string: "https://image.tmdb.org/t/p/w\(size)\(semiPath)")!
        }
    }
    
    
    
    
    
}
