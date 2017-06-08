//
//  ViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Henrique Jordão on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {

	@IBOutlet var searchBar: UISearchBar!
	@IBOutlet var mainCollectionView: UICollectionView!
	@IBOutlet var MyMoviesButton: UIButton!
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieYear: UILabel!
	
	@IBOutlet var star1: UIImageView!
	@IBOutlet var star2: UIImageView!
	@IBOutlet var star3: UIImageView!
	@IBOutlet var star4: UIImageView!
	@IBOutlet var star5: UIImageView!
	
    @IBOutlet weak var lupaItem: UIButton!
	
	let transition = TransitionAnimator()
    
    var nowPlayingMoviesModel: MovieModel!
    
    let requester = RequestsManager()
	
    var middleCellIndex: IndexPath!
    
    var posterArray: [UIImage?] = []
    
    var onlyOnce = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
		self.transitioningDelegate = self
		mainCollectionView.delegate = self
		mainCollectionView.dataSource = self
		mainCollectionView.prefetchDataSource = self
		
		refreshRating(rating: 5.0, isUserRating: false)
        searchBar.isHidden = true
		
        //self.navigationItem.leftBarButtonItem
		
        //searchBar.backgroundColor =  UIColor.init(colorLiteralRed: 127/255, green: 15/255, blue: 95/255, alpha: 1.0)
        //let screenSize = UIScreen.main.bounds.size
        //let cellWidth = floor(screenSize.width * 0.6)
        //let cellHeight = floor(screenSize.height * 0.4)
//        let insetX = (view.bounds.width - cellWidth)/2.0
//        let insetY = (view.bounds.height - cellHeight)/2.0
//        let layout = mainCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        
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
            
//            for movie in movieList.movieArray{
//                let image: UIImage = self.requester.getImageFromImageUrl(semiPath: movie.posterPath, size: -1)
//                self.posterArray.append(image)
//            }
            
            self.nowPlayingMoviesModel = movieList
            self.nowPlayingMoviesModel.movieArray.insert(Movie(), at: 0)
            self.nowPlayingMoviesModel.movieArray.insert(Movie(), at: self.nowPlayingMoviesModel.movieArray.count)
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
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.mainCollectionView.cellForItem(at: self.middleCellIndex)?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                    
                    
                    if(self.middleCellIndex.item == 1){
                        self.middleCellIndex = IndexPath(item: 1, section: 0)
                    } else{
                        self.middleCellIndex = IndexPath(item: self.middleCellIndex.item - 1, section: 0)
                    }
                    
                        
                    self.mainCollectionView.scrollToItem(at: self.middleCellIndex, at: .centeredHorizontally, animated: true)
                    
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.mainCollectionView.cellForItem(at: self.middleCellIndex)?.transform = CGAffineTransform(scaleX: 1.02  , y: 1.5)
                    })
                    
                    
                }
            case UISwipeGestureRecognizerDirection.left:
                if(self.middleCellIndex.item < self.mainCollectionView.numberOfItems(inSection: 0) - 2){
                    
                    UIView.animate(withDuration: 0.1, animations: {
                        self.mainCollectionView.cellForItem(at: self.middleCellIndex)?.transform = CGAffineTransform(scaleX: 1, y: 1)
                    })
                    
                    self.middleCellIndex =  IndexPath(item: self.middleCellIndex.item + 1, section: 0)
                   
                    self.mainCollectionView.scrollToItem(at: self.middleCellIndex, at: .centeredHorizontally, animated: true)
                    UIView.animate(withDuration: 0.1, animations: {
                        self.mainCollectionView.cellForItem(at: self.middleCellIndex)?.transform = CGAffineTransform(scaleX: 1.02, y: 1.5)
                    })
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

    @IBAction func lupaPressed(_ sender: Any) {
        
        searchBar.isHidden = false
        searchBar.backgroundImage = UIImage()
//        searchBar.showsCancelButton = true
        searchBar.tintColor = UIColor.white
        self.lupaItem.isHidden = true
        
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
	
	func refreshRating (rating: CGFloat, isUserRating: Bool) {
		
		let movieRating = rating / 2
		
		if isUserRating {
			switch movieRating {
			case 4.76...5.0:
				star5.image = UIImage(named: "averageStarFull")
				star4.image = UIImage(named: "averageStarFull")
				star3.image = UIImage(named: "averageStarFull")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 4.26...4.75:
				star5.image = UIImage(named: "averageStarHalf")
				star4.image = UIImage(named: "averageStarFull")
				star3.image = UIImage(named: "averageStarFull")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 3.76...4.25:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarFull")
				star3.image = UIImage(named: "averageStarFull")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 3.26...3.75:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarHalf")
				star3.image = UIImage(named: "averageStarFull")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 2.76...3.25:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarFull")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 2.26...2.75:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarHalf")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 1.76...2.25:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarFull")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 1.26...1.75:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarHalf")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 0.76...1.25:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarEmpty")
				star1.image = UIImage(named: "averageStarFull")
				break
			case 0.26...0.75:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarEmpty")
				star1.image = UIImage(named: "averageStarHalf")
				break
			default:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarEmpty")
				star1.image = UIImage(named: "averageStarEmpty")
			}
		} else {
			switch rating {
			case 5:
				star5.image = UIImage(named: "userStarFull")
				star4.image = UIImage(named: "userStarFull")
				star3.image = UIImage(named: "userStarFull")
				star2.image = UIImage(named: "userStarFull")
				star1.image = UIImage(named: "userStarFull")
				break
			case 4:
				star5.image = UIImage(named: "userStarEmpty")
				star4.image = UIImage(named: "userStarFull")
				star3.image = UIImage(named: "userStarFull")
				star2.image = UIImage(named: "userStarFull")
				star1.image = UIImage(named: "userStarFull")
				break
			case 3:
				star5.image = UIImage(named: "userStarEmpty")
				star4.image = UIImage(named: "userStarEmpty")
				star3.image = UIImage(named: "userStarFull")
				star2.image = UIImage(named: "userStarFull")
				star1.image = UIImage(named: "userStarFull")
				break
			case 2:
				star5.image = UIImage(named: "userStarEmpty")
				star4.image = UIImage(named: "userStarEmpty")
				star3.image = UIImage(named: "userStarEmpty")
				star2.image = UIImage(named: "userStarFull")
				star1.image = UIImage(named: "userStarFull")
				break
			case 1:
				star5.image = UIImage(named: "userStarEmpty")
				star4.image = UIImage(named: "userStarEmpty")
				star3.image = UIImage(named: "userStarEmpty")
				star2.image = UIImage(named: "userStarEmpty")
				star1.image = UIImage(named: "userStarFull")
				break
			default:
				star5.image = UIImage(named: "averageStarEmpty")
				star4.image = UIImage(named: "averageStarEmpty")
				star3.image = UIImage(named: "averageStarEmpty")
				star2.image = UIImage(named: "averageStarEmpty")
				star1.image = UIImage(named: "averageStarEmpty")
			}
		}
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
		cell.setCellMovie(movie: nowPlayingMoviesModel.movieArray[indexPath.item])
		//        if(indexPath.item > 0){
		//                cell.movieImageView.image = posterArray[indexPath.row-1]
		//        }
		
		//cell.movieImageView.image = requester.getImageFromImageUrl(semiPath: (cell.movie?.posterPath)!, size: -1)
		
		
		if(indexPath.item == 1 && self.middleCellIndex == nil){
			self.middleCellIndex = IndexPath(item: 1, section: 0)
		}
		
		return cell
	}
	
// MARK: - SearchBar Settings
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //performSegue(withIdentifier: , sender: nil)
        // let mySegue = UIStoryboardSegue.init(identifier: , source: self, destination: SearchViewController as! UIViewController)
        // prepare(for: <#T##UIStoryboardSegue#>, sender: <#T##Any?#>)
        
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
        
        secondViewController.searchText = searchBar.text
        
        self.goToSearch()
        
        //self.present(secondViewController, animated: true, completion: nil)
        
        //self.performSegue(withIdentifier: "goToSearch", sender: self)
        
        //performSegue(withIdentifier: "goToSearchResults", sender: self)
        
        
    }
	
    func goToSearch() {
    
        let main: UIStoryboard  = UIStoryboard.init(name: "Main", bundle: nil)
        let destination: SearchViewController = main.instantiateViewController(withIdentifier: "search") as! SearchViewController
        destination.searchText =  searchBar.text
    //DispatchQueue.main.async(execute: {
    self.present(destination, animated: true, completion: nil)
        
    //})    });
    }
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		self.searchBar.resignFirstResponder()
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.searchBar.resignFirstResponder()
		searchBar.isHidden = true
		self.lupaItem.isHidden = false
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








