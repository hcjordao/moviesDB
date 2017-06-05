//
//  Movie.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Movie: AnyObject {
    
    let originalTitle: String
    let releaseDate: String
    let castList: [Actors]! // depois
    let language: String
    let duration: Int! // depois
    let overview: String
    let posterPath: String
    var genres: [Int]
    let rating: Float
    let id: Int
    
    
    
    init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:[Int], rating:Float, id:Int) {
        
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.language = language
        self.overview = overview
        self.posterPath = posterPath
        self.genres = genres
        self.rating = rating
        self.id = id
        self.castList = nil
        self.duration = nil
    }
    
    init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:[Int], rating:Float, id:Int, duration:Int, castList:[Actors]) {
        
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.language = language
        self.overview = overview
        self.posterPath = posterPath
        self.genres = genres
        self.rating = rating
        self.id = id
        self.castList = castList
        self.duration = duration
        
    }
    
 
    
    
    
    

    
    

}
