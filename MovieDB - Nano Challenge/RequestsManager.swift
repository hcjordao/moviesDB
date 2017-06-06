//
//  RequestsManager.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit


enum SearchType{
    
    case NameSearch
    case CurrentTheaterSearch
    
}

class RequestsManager: AnyObject {
    
    
    let urlManager = URLManager()
    
    
    
    // Returns a list of movies that matches with the movie name informed
    
    func getMovieInformationByMovieId(movieID:Int, responseMovie:@escaping (_ movie:Movie)->Void){
        
        
        let request = URLRequest(url:self.urlManager.getMovieInformationURLFromMovieID(movieID: movieID))
        
        let session = URLSession.shared
        
        var movieToReturn:Movie!
        
        var actorsToInsert:[Actors] = []
        
        var imagesToInsert:[Images] = []
        
        var directorToInsert:String = ""
        
        session.dataTask(with: request){(data, response, error) in
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let movie = json as? [String:Any] {
                    
                    // Getting the images information
                    
                    
                    if let media = movie ["images"] as? [String:Any]{
                        
                        
                        if let imagesList=media["posters"] as? Array<NSDictionary>{
                            
                            
                            for image in imagesList{
                                
                                imagesToInsert.append(Images(imagePath: image["file_path"] as! String))
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    // Getting the actors information
                    
                    if let casts = movie ["casts"] as? [String:Any]{
                        
                        // Getting the movie actors
                        
                        if let actorsList=casts["cast"] as? Array<NSDictionary>{
                            
                            
                            for actor in actorsList{
                                
                                // Not all the actors have a profile path image
                                
                                if let profile_path = actor["profile_path"] as? String{
                                 
                                    actorsToInsert.append(Actors(name: actor["name"] as! String, profilePath: profile_path))
                                    
                                }
                                
                                
                            }
                            
                        }
                        
                        // Getting the movie director
                        
                        if let crewList=casts["crew"] as? Array<NSDictionary>{
                            
                            
                            for crew in crewList{
                                
                                // Not all the actors have a profile path image
                                
                                if let job_assignment = crew["job"] as? String{
                                    
                                    if(job_assignment == "Director"){
                                        if let crewName = crew["name"]{
                                            directorToInsert =  crew["name"] as! String
                                            
                                        }
                                        
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    
                    
                    }
                    
                    
                    // Getting the movie information from the Json main dictionary path
                    
                    
                    var originalTitle:String = ""
                    var releaseData:String = ""
                    var originalLanguage:String = ""
                    var overView:String = ""
                    var posterPath:String = ""
                    var vote_average:Float = -1.0
                    var runtime:Int = -1
                    var genres:[NSDictionary] = []
                    //var director:String = ""
                    
                    if let originaltitle = movie["original_title"] as? String{
                        
                        originalTitle = originaltitle
                    }
                    if let releasedata = movie["release_date"] as? String{
                        
                        releaseData = releasedata
                    }
                    if let originallanguage = movie["original_language"] as? String{
                        originalLanguage = originallanguage
                    }
                    if let overview = movie["overview"] as? String{
                        overView = overview
                        
                    }
                    if let posterpath = movie["poster_path"] as? String{
                        posterPath = posterpath
                    }
                    if let voteAverage = movie["vote_average"] as? Float{
                        
                        vote_average = voteAverage
                    }
                    
                    if let runTime = movie["runtime"] as? Int{
                        
                        runtime = runTime
                    }
                    if let Genres = (movie["genres"] as? Array<NSDictionary>){
                        genres = Genres
                    }
                   
                    
                            movieToReturn  = Movie(originalTitle: originalTitle,
                                                            releaseDate: releaseData,
                                                            language: originalLanguage,
                                                            overview: overView,
                                                            posterPath: posterPath,
                                                            genres: genres,
                                                            rating: vote_average,
                                                            id: movie["id"] as! Int,
                                                            duration: runtime,
                                                            castList: actorsToInsert,
                                                            movieImages: imagesToInsert,
                                                            director:directorToInsert)
                            
                         print(movie)
                            
                    
                        responseMovie(movieToReturn)
                       
                        
                    
                    
                }
                
            }catch let error {
                
                print((error.localizedDescription))
                
                
            }
            
            
            }.resume()

        
    }
    
    
    // search used for name or for current movies in theater
    
    func getMoviesInTheaterInformation(search:SearchType, movieName:String,responseMovies:@escaping (_ movie:MovieModel)->Void){
        
        
        let request:URLRequest!
        
        if(search == .NameSearch){
            request = URLRequest(url:self.urlManager.getMoviesUrlSearchForMovieName(movieName: movieName))
        }
        else{
            request = URLRequest(url:self.urlManager.getCurrentMoviesInTheaterUrl())
        }
        
        let session = URLSession.shared
        
        let movieList = MovieModel()
        
        
        session.dataTask(with: request){(data, response, error) in
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let dic = json as? [String:Any]{
                    
                    if let res = dic ["results"] as? Array<NSDictionary>{
                        
                        
                        for movies in res{
                            
                            
                            if let posterPath = movies["poster_path"]{
                                movieList.addMovie(movie: Movie(originalTitle: movies["original_title"] as! String,
                                                                releaseDate: movies["release_date"] as! String,
                                                                language: movies["original_language"] as! String,
                                                                overview: movies["overview"] as! String,
                                                                posterPath: posterPath as! String,
                                                                genres: (movies["genre_ids"] as? Array<Int>)!,
                                                                rating: movies["vote_average"] as! Float,
                                                                id: movies["id"] as! Int))

                            
                            }
                            else{
                                
                            
                        
                            movieList.addMovie(movie: Movie(originalTitle: movies["original_title"] as! String,
                                                            releaseDate: movies["release_date"] as! String,
                                                            language: movies["original_language"] as! String,
                                                            overview: movies["overview"] as! String,
                                                            posterPath: "",
                                                            genres: (movies["genre_ids"] as? Array<Int>)!,
                                                            rating: movies["vote_average"] as! Float,
                                                            id: movies["id"] as! Int))
                            }
                            
                        }
                        
                        responseMovies(movieList)
                        
                    }
                    
                }
                
            }catch let error {
                
                print((error.localizedDescription))
                
                
            }
            
            
            }.resume()
    
    }
    
    

    
}
    

    
    

