//
//  DescriptionViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Douglas Gehring on 07/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class DescriptionViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDelegateFlowLayout{

    @IBOutlet weak var fakeNavBar: UIView!
    
    @IBOutlet weak var movieTitle: UILabel!
    
    @IBOutlet weak var backgroundImgForMovie: UIImageView!
    
    @IBOutlet weak var collectionViewActors: UICollectionView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    /** Constraints to modify **/
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var distanceBetweenMovieTitleAndTextConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var movieDirector: UILabel!
    
    @IBOutlet weak var genresAndDurationLabel: UILabel!
    
    @IBOutlet weak var cameraViewImage: UIImageView!
    
    @IBOutlet weak var personMovieWatchedImage: UIImageView!
    
    @IBOutlet weak var Star1: UIImageView!
    
    @IBOutlet weak var Star2: UIImageView!
    
    @IBOutlet weak var Star5: UIImageView!
    
    @IBOutlet weak var Star3: UIImageView!
    
    @IBOutlet weak var Star4: UIImageView!
    
    var requestest:RequestsManager!
    var movie:Movie!
    var cast:[Actors] = []
    var id:Int!
    
    var userAlreadyWatched = false
    
    var currentUserAverageForMovie:Int!
    
    let picker = UIImagePickerController()
    
    var iPadDevice = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(self.contentView.frame.size.width >= 768){
            
           self.iPadDevice = true
        }else{
            self.iPadDevice = false
            
        }
        
        self.collectionViewActors.delegate = self
        self.collectionViewActors.dataSource = self
        self.scrollView.delegate = self
        self.picker.delegate = self
        
        
        self.requestest = RequestsManager()
        
        self.personMovieWatchedImage.layer.cornerRadius = 70/2
        self.personMovieWatchedImage.layer.masksToBounds = false
        self.personMovieWatchedImage.clipsToBounds = true
        
        self.setShadowToFakeNavBar()
        
        // verifiy user defaults!
        
        self.userAlreadyWatched = true
        
        self.contentView.backgroundColor = UIColor.clear
        
        self.setGradientBackground()
        
        
        self.id = 671
        
        
        
        // Movie does not have all information
        
        if(true){
            
            
            self.requestest.getMovieInformationByMovieId(movieID: self.id) { (Movie) in
                
                
                self.movie = Movie
                
                
                DispatchQueue.main.async {
                    
                    print(self.movie.overview)
                    
                    self.settingMovieInformationToLabelsWithMovie(movie: self.movie)
                    
                    self.collectionViewActors.reloadData()
                    
                    self.verifyingConstraintsForIpadDevice()
                    
                }
                
                
                
            }
            
            
            
            
        }
        
        else{
            
            self.settingMovieInformationToLabelsWithMovie(movie: self.movie)
            
        }
        

        
        
        // Do any additional setup after loading the view.
    }
    
    
    func settingMovieInformationToLabelsWithMovie(movie:Movie){
        
        self.cast = self.movie.castList
        
        self.overviewLabel.text = self.movie.overview
        
        self.movieTitle.text = self.movie.originalTitle
        
        self.backgroundImgForMovie.image = self.requestest.getImageFromImageUrl(semiPath: self.movie.backDropPath, size: 500)
        self.setGenderAndMovieDurationToLabel()
        self.movieDirector.text = self.movie.director
        self.refreshRating(rating: CGFloat(self.movie.rating), isUserRating: false)
        
        self.collectionViewActors.reloadData()
        
        
        
    }
 
    
    func verifyingConstraintsForIpadDevice(){
        
        if(!self.iPadDevice){
            
            
            self.heightConstraint.constant += self.overviewLabel.intrinsicContentSize.height
            self.heightConstraint.constant += (self.movieTitle.intrinsicContentSize.height)
            
            
            
        }
        else{
            
            if(self.overviewLabel.intrinsicContentSize.height>=10){
                
                self.heightConstraint.constant+=(20+self.overviewLabel.intrinsicContentSize.height/3)
                self.distanceBetweenMovieTitleAndTextConstraint.constant = (self.contentView.intrinsicContentSize.height*0.43)
                
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cast.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellActors", for: indexPath) as! ActorsCostumCollectionViewCell
        
        
        
        cell.actorName.text =  self.movie.castList[indexPath.row].name
        cell.actorRole.text =  self.movie.castList[indexPath.row].role

        cell.actorImageView.image = self.requestest.getImageFromImageUrl(semiPath: self.movie.castList[indexPath.row].profilePath, size: 500)
        
        
            
            
        cell.actorImageView.layer.borderWidth = 3
        cell.actorImageView.layer.borderColor = UIColor.init(red: 127/255, green: 16/255, blue: 95/255, alpha: 1.0).cgColor
        
        return cell
     
    }
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        
        /* Setting again gradient configurations */
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
    
    func setGenderAndMovieDurationToLabel(){
        
        self.genresAndDurationLabel.text = ""
        
        self.genresAndDurationLabel.text?.append(String(self.movie.duration)+" | ")
        
        for genre in self.movie.genres{
            
            if(movie.genres.last != genre){
             
                self.genresAndDurationLabel.text?.append(genre+" | ")
                
            }else{
                
                self.genresAndDurationLabel.text?.append(genre)
            }
        }
        
    }
    
    
    
    /************ PICKER METHODS *******************/
   
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func photoButtonSelected(_ sender: Any) {
        
        self.settingConfigurationForImageTouch()
        
    }
    
    
    
    func settingConfigurationForImageTouch(){
        
        let alert = UIAlertController(title: "", message: "Image Source",
                                      preferredStyle: .actionSheet)
        
        let action = UIAlertAction(title: "Galery", style: .default) { (act) in
            
            self.picker.allowsEditing = false
            self.picker.sourceType = .photoLibrary
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.present(self.picker, animated: true, completion: nil)
            
        }
        
        let action2 = UIAlertAction(title: "Camera", style: .default) { (act) in
            
            self.picker.allowsEditing = false
            self.picker.sourceType = UIImagePickerControllerSourceType.camera
            self.picker.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
            
            self.present(self.picker, animated: true, completion: nil)
            
        }
        
        
        alert.addAction(action)
        alert.addAction(action2)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: false, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        self.settingImageToSpecificView(selectedView: self.personMovieWatchedImage, info: info)
        
    }
    
    
    func settingImageToSpecificView(selectedView:UIImageView, info: [String : Any]){
        
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            selectedView.image = image
            self.cameraViewImage.isHidden = true
        }
        
        dismiss(animated: true) {
            
            
            
        }
        
    }
    
    
    
    func resetRating(){
        
        refreshRating(rating: CGFloat(0), isUserRating: true)
    }
    
    
    @IBAction func buttonToStar1Pressed(_ sender: Any) {
        
        if(self.userAlreadyWatched){
            
            self.currentUserAverageForMovie = 1
            resetRating()
            refreshRating(rating: CGFloat(1), isUserRating: true)
            
        }
    }
    
    

    @IBAction func buttonToStar2Presssed(_ sender: Any) {
       
        
        if(self.userAlreadyWatched){
         
            self.currentUserAverageForMovie = 2
            resetRating()
            refreshRating(rating: CGFloat(2), isUserRating: true)
            
            
        }
    }
    
    
    
    @IBAction func buttonToStar3Pressed(_ sender: Any) {
        
        if(self.userAlreadyWatched){
            
            self.currentUserAverageForMovie = 3
            resetRating()
            refreshRating(rating: CGFloat(3), isUserRating: true)

            
        }
    }
    
    
    @IBAction func buttonToStar4Pressed(_ sender: Any) {
        
        if(self.userAlreadyWatched){
            self.currentUserAverageForMovie = 4
            resetRating()
            refreshRating(rating: CGFloat(4), isUserRating: true)
        }
    }
    
    
    
    
    
    @IBAction func buttonToStar5Pressed(_ sender: Any) {
        
        if(self.userAlreadyWatched){
            self.currentUserAverageForMovie = 5
            resetRating()
            refreshRating(rating: CGFloat(5), isUserRating: true)

        }
        
    }
    
    
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
        } else {
            print("Portrait")
        }
    }
    
    
    
    func refreshRating (rating: CGFloat, isUserRating: Bool) {
        
        var movieRating = rating
        
        if(!isUserRating){
            
            movieRating = movieRating/2
        }
        
        if !isUserRating {
            switch movieRating {
            case 4.76...5.0:
                self.Star5.image = UIImage(named: "averageStarFull")
                self.Star4.image = UIImage(named: "averageStarFull")
                self.Star3.image = UIImage(named: "averageStarFull")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 4.26...4.75:
                self.Star5.image = UIImage(named: "averageStarHalf")
                self.Star4.image = UIImage(named: "averageStarFull")
                self.Star3.image = UIImage(named: "averageStarFull")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 3.76...4.25:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarFull")
                self.Star3.image = UIImage(named: "averageStarFull")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 3.26...3.75:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarHalf")
                self.Star3.image = UIImage(named: "averageStarFull")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 2.76...3.25:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarFull")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 2.26...2.75:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarHalf")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 1.76...2.25:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarFull")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 1.26...1.75:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarHalf")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 0.76...1.25:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarEmpty")
                self.Star1.image = UIImage(named: "averageStarFull")
                break
            case 0.26...0.75:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarEmpty")
                self.Star1.image = UIImage(named: "averageStarHalf")
                break
            default:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarEmpty")
                self.Star1.image = UIImage(named: "averageStarEmpty")
            }
        } else {
            switch rating {
            case 5:
                self.Star5.image = UIImage(named: "userStarFull")
                self.Star4.image = UIImage(named: "userStarFull")
                self.Star3.image = UIImage(named: "userStarFull")
                self.Star2.image = UIImage(named: "userStarFull")
                self.Star1.image = UIImage(named: "userStarFull")
                break
            case 4:
                self.Star5.image = UIImage(named: "userStarEmpty")
                self.Star4.image = UIImage(named: "userStarFull")
                self.Star3.image = UIImage(named: "userStarFull")
                self.Star2.image = UIImage(named: "userStarFull")
                self.Star1.image = UIImage(named: "userStarFull")
                break
            case 3:
                self.Star5.image = UIImage(named: "userStarEmpty")
                self.Star4.image = UIImage(named: "userStarEmpty")
                self.Star3.image = UIImage(named: "userStarFull")
                self.Star2.image = UIImage(named: "userStarFull")
                self.Star1.image = UIImage(named: "userStarFull")
                break
            case 2:
                self.Star5.image = UIImage(named: "userStarEmpty")
                self.Star4.image = UIImage(named: "userStarEmpty")
                self.Star3.image = UIImage(named: "userStarEmpty")
                self.Star2.image = UIImage(named: "userStarFull")
                self.Star1.image = UIImage(named: "userStarFull")
                break
            case 1:
                self.Star5.image = UIImage(named: "userStarEmpty")
                self.Star4.image = UIImage(named: "userStarEmpty")
                self.Star3.image = UIImage(named: "userStarEmpty")
                self.Star2.image = UIImage(named: "userStarEmpty")
                self.Star1.image = UIImage(named: "userStarFull")
                break
            default:
                self.Star5.image = UIImage(named: "averageStarEmpty")
                self.Star4.image = UIImage(named: "averageStarEmpty")
                self.Star3.image = UIImage(named: "averageStarEmpty")
                self.Star2.image = UIImage(named: "averageStarEmpty")
                self.Star1.image = UIImage(named: "averageStarEmpty")
            }
        }
    }

    
    func setShadowToFakeNavBar(){
        
        self.fakeNavBar.layer.shadowColor = UIColor.black.cgColor
        self.fakeNavBar.layer.shadowOpacity = 1
        self.fakeNavBar.layer.shadowOffset = CGSize.zero
        self.fakeNavBar.layer.shadowRadius = 30
        
        self.fakeNavBar.layer.shadowPath = UIBezierPath(rect: self.fakeNavBar.bounds).cgPath
        self.fakeNavBar.layer.shouldRasterize = true
    }
    
    func refreshCollectionView() {
        DispatchQueue.main.async(execute: {
            self.collectionViewActors.reloadData()
        })
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
