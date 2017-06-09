//
//  Movie.swift
//  MovieDB - Nano Challenge
//
//  Created by Laura Corssac on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class Movie:  NSObject, NSCoding {
    
    var originalTitle: String
    var releaseDate: String
    var castList: [Actors]! // depois
    var language: String
    var duration: Int! // depois
    var overview: String
    var posterPath: String
    var genres: [String] = []
    var rating: Float
    var id: Int
    var movieImages:[Images]!
    var director: String!
    var backDropPath: String!
    var userPhoto: UIImage!
    
    
    override init() {
        
        
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
        userPhoto = UIImage()
        super.init()
    }
    
    
    convenience  init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:Array<Any>, rating:Float, id:Int, backGround:String) {
        
        self.init()
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.language = language
        self.overview = overview
        self.posterPath = posterPath
        self.rating = rating
        self.id = id
        self.userPhoto = UIImage()
        self.castList = nil
        self.duration = nil
        self.movieImages = nil
        self.director = nil
        self.backDropPath = backGround
        self.genres = self.setMovieGendersByIdAndSearchForName(genders: genres)
        

        
    }
    
    convenience init(originalTitle:String, releaseDate:String, language:String, overview:String, posterPath:String, genres:Array<NSDictionary>, rating:Float, id:Int, duration:Int, castList:[Actors], movieImages:[Images], director:String, backGroung:String) {
        self.init()
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
        self.userPhoto = UIImage()
        self.genres = self.setMovieGendersById(genders: genres)
       
        
        
    }
    
    func getYearFromReleaseDate() -> String {
        
        let index = self.releaseDate.index(self.releaseDate.startIndex, offsetBy:4)

        let year = "(" + self.releaseDate.substring(to: index) + ")"
        
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
    
    
    required init(coder decoder: NSCoder) {
        self.originalTitle = decoder.decodeObject(forKey: "title") as? String ?? ""
        self.releaseDate = decoder.decodeObject(forKey: "releaseDate") as? String ?? ""
        
       
        self.language = decoder.decodeObject(forKey: "language") as? String ?? ""
        self.overview = decoder.decodeObject(forKey: "overview") as? String ?? ""
        self.posterPath = decoder.decodeObject(forKey: "posterPath") as? String ?? ""
        
        self.rating =  decoder.decodeFloat(forKey: "rating")
        
        self.id = decoder.decodeInteger(forKey: "id")
        
        self.duration = decoder.decodeObject(forKey: "duration") as? Int
        //self.movieImages = decoder.decodeObject(forKey: "image") as? [Images] ?? []
        self.director = decoder.decodeObject(forKey: "director") as? String ?? ""
        self.backDropPath = decoder.decodeObject(forKey: "backDropPath") as? String ?? ""
        self.genres = decoder.decodeObject(forKey: "genres") as! [String]
        self.castList = decoder.decodeObject(forKey: "castList") as? [Actors] ?? []
        self.userPhoto = decoder.decodeObject(forKey: "userPhoto") as? UIImage 


    }
    
    func encode(with coder: NSCoder) {
        coder.encode(originalTitle, forKey: "title")
        coder.encode(releaseDate, forKey: "releaseDate")
        coder.encode(language, forKey: "language")
        coder.encode(overview, forKey: "overview")
        coder.encode(posterPath,  forKey: "posterPath")
        
        coder.encode(rating, forKey: "rating")
        coder.encode(id, forKey: "id")
        coder.encode(duration, forKey: "duration")
        //coder.encode(movieImages, forKey: "image")
        coder.encode(director, forKey: "director")
        coder.encode(backDropPath, forKey: "backDropPath")
        coder.encode(genres, forKey: "genres")
        coder.encode(castList, forKey: "castList")
        
        coder.encode(userPhoto, forKey:"userPhoto")

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
