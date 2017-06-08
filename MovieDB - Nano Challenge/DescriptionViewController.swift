//
//  DescriptionViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 07/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource{

    
    @IBOutlet weak var backgroundImgForMovie: UIImageView!
    
    @IBOutlet weak var collectionViewActors: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var requestest:RequestsManager!
    var movie:Movie!
    var actors:[Actors] = []
    var imgsDataArray:[Data] = []
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionViewActors.delegate = self
        self.collectionViewActors.dataSource = self
        self.scrollView.delegate = self
     
        self.requestest = RequestsManager()
        
        
        self.contentView.backgroundColor = UIColor.clear
        
        self.setGradientBackground()
        
        self.requestest.getMovieInformationByMovieId(movieID: 671) { (Movie) in
            
            
            self.movie = Movie
            
            print(self.movie.overview)
            
            self.actors = self.movie.castList
            
            self.overviewLabel.text = self.movie.overview
            
            
            self.heightConstraint.constant += self.overviewLabel.intrinsicContentSize.height
            
            
            /*
            for cast in self.movie.castList{
                
                self.requestest.getImageFromImageUrl(semiPath: cast.profilePath,size: 500,responseImg: { (data) in
                    
                    self.imgsDataArray.append(data)
                    
                    
                })
                
            }
            
           self.requestest.getImageFromImageUrl(semiPath: "/gjOiE5EYH5sqcJYlSDZnVWRMgNV.jpg", size: 500, responseImg: { (data) in
                
                var img = UIImage(data:data)!
                
                //self.scrollView.backgroundColor = UIColor(patternImage:img)
                self.backgroundImgForMovie.image = img
            })
            
 */
            self.collectionViewActors.reloadData()
            
        
        }

        
        
        // Do any additional setup after loading the view.
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return actors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellActors", for: indexPath) as! ActorsCostumCollectionViewCell
        
        cell.actorName.text = self.actors[indexPath.row].name
        
        
        cell.actorImageView.image = UIImage.init(data: self.imgsDataArray[indexPath.row])
        
        cell.actorImageView.layer.borderWidth = 3
        cell.actorImageView.layer.borderColor = UIColor.init(red: 127/255, green: 16/255, blue: 95/255, alpha: 1.0).cgColor
        
        return cell
     
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        self.scrollView.layer.sublayers?.remove(at: 0)
        setGradientBackground()
        
    }
    
    func setGradientBackground() {
        
        let colorTop =  UIColor(red: 127.0/255.0, green: 16.0/255.0, blue: 95.0/255.0, alpha: 0.3).cgColor
        let colorBottom = UIColor(red: 127.0/255.0, green: 16.0/255.0, blue: 95.0/255.0, alpha: 0.8).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [ colorTop, colorBottom]
        gradientLayer.locations = [ 0.0, 1.0]
        gradientLayer.frame = self.scrollView.bounds
        
        self.scrollView.layer.insertSublayer(gradientLayer, at: 0)
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
