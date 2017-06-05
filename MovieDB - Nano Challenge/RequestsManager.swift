//
//  RequestsManager.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit


class RequestsManager: AnyObject {
    
    
    let urlManager = URLManager()
    
    
    
    
    
    func getMovieInformationByMovieId(movieID:Int)->Movie{
        
        
        let request = URLRequest(url:self.urlManager.getMovieInformationURLFromMovieID(movieID: movieID))
        
        let session = URLSession.shared
        
        var movieToReturn:Movie!
        
        var actorsToInsert:[Actors]!
        
        session.dataTask(with: request){(data, response, error) in
            
            do{
                
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                if let movie = json as? [String:Any] {
                    
                    // Getting the images information
                    
                    
                    if let media = movie ["images"] as? [String:Any]{
                        
                        
                        if let imagesList=media["posters"] as? Array<NSDictionary>{
                            
                            
                            for image in imagesList{
                                
                                actorsToInsert.append(Actors(name: actor["name"] as! String, profilePath: actor["profile_path"] as! String))
                                
                            }
                            
                        }
                        
                        
                    }
                    
                    
                    
                    
                    // Getting the actors information
                    
                    if let casts = movie ["casts"] as? [String:Any]{
                        

                        if let actorsList=casts["cast"] as? Array<NSDictionary>{
                            
                            
                            for actor in actorsList{
                                
                                actorsToInsert.append(Actors(name: actor["name"] as! String, profilePath: actor["profile_path"] as! String))
                                
                            }
                            
                        }
                    
                    
                    }
                    
                    
                    // Getting the movie information from the Json main dictionary path
                    
                    if let movieInfo = movie["JSON"] as? Array<NSDictionary>{
                        
                        for info in movieInfo{
                            
                            movieToReturn  = Movie(originalTitle: info["original_title"] as! String,
                                                            releaseDate: info["release_date"] as! String,
                                                            language: info["original_language"] as! String,
                                                            overview: info["overview"] as! String,
                                                            posterPath: info["poster_path"] as! String,
                                                            genres: info["genre_ids"] as! [Int],
                                                            rating: info["vote_average"] as! Float,
                                                            id: info["id"] as! Int,
                                                            duration: info["runtime"] as! Int,
                                                            castList: actorsToInsert)
                            
                            
                        }
                        
                    }
                    
                }
                
            }catch let error {
                
                print((error.localizedDescription))
                
                
            }
            
            
            }.resume()

        
        
        return movieToReturn
        
    }
    
    
    
    func getMoviesInTheaterInformation()->MovieModel{
        
        
        let request = URLRequest(url:self.urlManager.getCurrentMoviesInTheaterUrl())
        
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
                                                            genres: movies["genre_ids"] as! [Int],
                                                            rating: movies["vote_average"] as! Float,
                                                            id: movies["id"] as! Int))
                            
                            
                        }
                        
                    }
                    
                }
                
            }catch let error {
                
                print((error.localizedDescription))
                
                
            }
            
            
            }.resume()
    
    
        
      return movieList
    }
    
    
    func getMovieListFromUrlRequest(url:URL){
        
        
        
    }
        
    
}
    

    
    

