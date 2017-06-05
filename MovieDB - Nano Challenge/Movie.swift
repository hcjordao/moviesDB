//
//  Movie.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Movie: AnyObject {
    
    let originalTitle: String!
    let year: String!
    let actorsList: [ Actors]!
    let language: String!
    let duration: String!
    let portugueseTitle: String!
    let overview: String!
    let imagePath: String!
    var genres: [String] = []
    let rating: Float!
    let id: Int!
    
    
    
   
        
   // https://api.themoviedb.org/3/movie/500?api_key=f0e3c4fcec46612abd4acf735d09c4a6&language=en-US
    
    init(OriginalTitle: String, Year: String, ActorsList: [Actors], language: String, PortugueseTitle: String, Overview: String, ImagePath:String, Genres: [Int], Rating:Float, Id: Int) {
        self.actorsList = ActorsList
        
        
        
        
        
        //self.duration = Duration
        self.language = language
        self.originalTitle = OriginalTitle
        self.portugueseTitle = PortugueseTitle
        self.overview = Overview
        self.year = Year
        self.imagePath = ImagePath
        self.rating = Rating
        self.id  = Id
        self.genres = []
        for gender in Genres
        {
            self.genres.append(self.getGenderFromId(id: gender))
        }
    
        
    
        
    }
    
    
    
    
   // https://api.themoviedb.org/3/movie/now_playing?api_key=f0e3c4fcec46612abd4acf735d09c4a6&language=pt-BR
    
    
    

}
