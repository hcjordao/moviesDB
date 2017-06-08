//
//  ViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Henrique Jordão on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {

	@IBOutlet var mainCollectionView: UICollectionView!
	@IBOutlet var MyMoviesButton: UIButton!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
	
	let transition = TransitionAnimator()
    
    var nowPlayingMoviesModel: MovieModel!
    
    let requester = RequestsManager()
	
    var middleCellIndex: IndexPath!
    
    var onlyOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
		self.transitioningDelegate = self
		mainCollectionView.delegate = self
		mainCollectionView.dataSource = self
		mainCollectionView.prefetchDataSource = self
        
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * 0.6)
        let cellHeight = floor(screenSize.height * 0.4)
        let insetX = (view.bounds.width - cellWidth)/2.0
        let insetY = (view.bounds.height - cellHeight)/2.0
        let layout = mainCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
        let swipeHorizontalRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeHorizontalRight.direction = UISwipeGestureRecognizerDirection.right
        let swipeHorizontalLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeHorizontalLeft.direction = UISwipeGestureRecognizerDirection.left
        
//        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        
        //mainCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        mainCollectionView?.addGestureRecognizer(swipeHorizontalRight)
        mainCollectionView?.addGestureRecognizer(swipeHorizontalLeft)
        
        self.nowPlayingMoviesModel = MovieModel()
        
        requester.getMoviesInTheaterInformation(search: .CurrentTheaterSearch, movieName: "") { (movieList) in
            
            self.nowPlayingMoviesModel = movieList
            self.nowPlayingMoviesModel.movieArray.insert(Movie(), at: 0)
            self.movieTitle.text = self.nowPlayingMoviesModel.movieArray[1].originalTitle
            self.movieYear.text = self.nowPlayingMoviesModel.movieArray[1].getYearFromReleaseDate()
            
            DispatchQueue.main.async { // Telling the code to run in the main thread
                self.mainCollectionView.reloadData()
                
                //self.updateMovieLabels()
                

            }
            
        }
        
    }
    
    
    func handleSwipe(gesture:UIGestureRecognizer) -> Void {
        
        self.updateMovieLabels()
        
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                if(self.middleCellIndex.item > 1){
                    
                    if(self.middleCellIndex.item == 1){
                        self.middleCellIndex = IndexPath(item: 1, section: 0)
                    } else{
                        self.middleCellIndex = IndexPath(item: self.middleCellIndex.item - 1, section: 0)
                    }
                    
                    DispatchQueue.main.async {
                        
                        self.mainCollectionView.scrollToItem(at: self.middleCellIndex, at: .centeredHorizontally, animated: true)
                    }
                    
                    
                }
            case UISwipeGestureRecognizerDirection.left:
                if(self.middleCellIndex.item < self.mainCollectionView.numberOfItems(inSection: 0)-1){
                    
                    self.middleCellIndex =  IndexPath(item: self.middleCellIndex.item + 1, section: 0)
                   
                    self.mainCollectionView.scrollToItem(at: self.middleCellIndex, at: .centeredHorizontally, animated: true)
                }
            default:
                break
            }
        }
        
        self.updateMovieLabels()
    }
    
    func updateMovieLabels() -> Void {
        if let cell: MainScreenCollectionViewCell = (self.mainCollectionView.cellForItem(at: middleCellIndex) as? MainScreenCollectionViewCell) {
            if(middleCellIndex.item != 0 ){
                self.movieTitle.text = cell.movie?.originalTitle
                self.movieYear.text = cell.movie?.getYearFromReleaseDate()
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func MyMoviesPressed(_ sender: Any) {
		
		let myMoviesViewController = storyboard!.instantiateViewController(withIdentifier: "MyMoviesViewController") as! MyMoviesViewController
		present(myMoviesViewController, animated: true, completion: nil)
		
		myMoviesViewController.transitioningDelegate = self
		
	}

// MARK: - CollectionView Settings
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// return movieModel.movies.count
		return nowPlayingMoviesModel.movieArray.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MainScreenCollectionViewCell
		
            cell.loadDefaultImg()
            cell.title.text = nowPlayingMoviesModel.movieArray[indexPath.item].originalTitle
            cell.setCellMovie(movie: nowPlayingMoviesModel.movieArray[indexPath.item])
        
        if(indexPath.item == 1 && self.middleCellIndex == nil){
            self.middleCellIndex = IndexPath(item: 1, section: 0)
            //self.mainCollectionView.scrollToItem(at: middleCellIndex, at: .centeredHorizontally, animated: false)
        }
        
        return cell
	}
}




// MARK: - CollectionView Data Source
extension ViewController: UIScrollViewDelegate, UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.onlyOnce == false {
            let indexToScrollTo = IndexPath(item: 1, section: 0)
            self.mainCollectionView.scrollToItem(at: indexToScrollTo, at: .centeredHorizontally, animated: false)
            self.onlyOnce = true
        }
    }
}

// MARK: - Prefetch
extension ViewController : UICollectionViewDataSourcePrefetching {
	func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
		// chama a classe com metodo pra preloadar as imagens
	}
}

// MARK: - Transition To My Movies
extension ViewController : UIViewControllerTransitioningDelegate {
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return nil
	}
	
}








