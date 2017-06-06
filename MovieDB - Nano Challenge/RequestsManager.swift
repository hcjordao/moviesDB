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
        
        var directorToInsert:String!
        
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
                                        
                                        directorToInsert =  crew["name"] as! String
                                    }
                                    
                                }
                                
                                
                            }
                            
                        }
                    
                    
                    }
                    
                    
                    // Getting the movie information from the Json main dictionary path
                    
                    
                            movieToReturn  = Movie(originalTitle: movie["original_title"] as! String,
                                                            releaseDate: movie["release_date"] as! String,
                                                            language: movie["original_language"] as! String,
                                                            overview: movie["overview"] as! String,
                                                            posterPath: movie["poster_path"] as! String,
                                                            genres: (movie["genres"] as? Array<NSDictionary>)!,
                                                            rating: movie["vote_average"] as! Float,
                                                            id: movie["id"] as! Int,
                                                            duration: movie["runtime"] as! Int,
                                                            castList: actorsToInsert,
                                                            movieImages: imagesToInsert,
                                                            director:directorToInsert)
                            
                            
                            
                    
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
                        
                            movieList.addMovie(movie: Movie(originalTitle: movies["original_title"] as! String,
                                                            releaseDate: movies["release_date"] as! String,
                                                            language: movies["original_language"] as! String,
                                                            overview: movies["overview"] as! String,
                                                            posterPath: movies["poster_path"] as! String,
                                                            genres: movies["genres"] as! Array<NSDictionary>,
                                                            rating: movies["vote_average"] as! Float,
                                                            id: movies["id"] as! Int))
                            
                            
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
    

    
    

