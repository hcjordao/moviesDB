//
//  RequestsManager.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit


class RequestsManager: AnyObject {
    
    
    func getMovieListFromUrlRequest(url:URL){
        
        
            let request = URLRequest(url:url)
        
            let session = URLSession.shared
        
            session.dataTask(with: request){(data, response, error) in
            
                do{
                
                    let json = try JSONSerialization.jsonObject(with: data!, options: [])
                
                    if let dic = json as? [String:Any]{
                    
                        if let res = dic ["results"] as? Array<NSDictionary>{
                            
                            
                        
                        }
    
                    }
                
                }catch let error {
                
                    print((error.localizedDescription))
                
                
                }
            
    
            }.resume()
        
       
    }
        
    
}
    

    
    

