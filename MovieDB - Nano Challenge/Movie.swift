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
    var genres: [String] = []
    let rating: Float
    let id: Int
    let movieImages:[Images]!
    let director: String!
    let backDropPath: String!
    
    init() {
        originalTitle = ""
        releaseDate = ""
        castList = [Actors()] // depois
        language = ""
        duration = 0 // depois
        overview = ""
        posterPath = ""
        genres = []
        rating = 0
        id = 0
        movieImages = [Images()]
        director = ""
        backDropPath = ""
    }
    
    
    init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:Array<Any>, rating:Float, id:Int, backGround:String) {
        
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.language = language
        self.overview = overview
        self.posterPath = posterPath
        self.rating = rating
        self.id = id
        self.castList = nil
        self.duration = nil
        self.movieImages = nil
        self.director = nil
        self.backDropPath = backGround
        self.genres = self.setMovieGendersByIdAndSearchForName(genders: genres)
        

        
    }
    
    init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:Array<NSDictionary>, rating:Float, id:Int, duration:Int, castList:[Actors], movieImages:[Images], director:String, backGroung:String) {
        
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.language = language
        self.overview = overview
        self.posterPath = posterPath
        self.rating = rating
        self.id = id
        self.castList = castList
        self.duration = duration
        self.movieImages = movieImages
        self.director = director
        self.backDropPath = backGroung
        self.genres = self.setMovieGendersById(genders: genres)
       
        
        
    }
    
    func getYearFromReleaseDate() -> String {
        
        let index = self.releaseDate.index(self.releaseDate.startIndex, offsetBy:4)

        let year = " (" + self.releaseDate.substring(to: index) + ")"
        
        return year
    }
    
    private func setMovieGendersByIdAndSearchForName(genders:Array<Any>)->[String]{
        
        var gendersArray:[String] = []
        
        for gender in genders{
            
            gendersArray.append(self.defineGenderById(id: gender as! Int))
            
            
        }
        
        return gendersArray
        
    }
    
    
    private func setMovieGendersById(genders:Array<NSDictionary>)->[String]{
        
        
        var genderArray:[String] = []
        
        for gender in genders{
            
            
                genderArray.append(self.defineGenderById(id: gender["id"] as! Int))
                
            
        }
        
        
        return genderArray
    }
    
    
    private func defineGenderById(id:Int)->String{
        
        
        switch id {
        case 28:
            return "Action"
            
        case 12:
            return "Adventure"
            
        case 16:
            return "Animation"
            
        case 35:
            return "Comedy"
            
        case 80:
            return "Crime"
            
        case 99:
            return "Documentary"
        case 18:
            return "Drama"
            
        case 10751:
            return "Family"
            
        case 14:
            return "Fantasy"
            
        case 36:
            return "History"
            
        case 27:
            return "Horror"
            
        case 10402:
            return "Music"
            
        case 9648:
            return "Mystery"
            
        case 10749:
            return "Romance"
            
        case 878:
            return"Science Fiction"
            
        case 10770:
            return "TV Movie"
            
        case 53:
            return "Thriller"
            
        case 10752:
            return "War"
            
        case 37:
            return "Western"
            
        default:
            return "None"
        }
        
        
        
    }
    
 
    
    
    
    

    
    

}
