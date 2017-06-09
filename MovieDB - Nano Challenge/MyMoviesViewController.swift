//
//  MyMoviesViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MyMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
	
	let transition = TransitionAnimator()
	
    var watchedMovies: [Movie]! = []
    
    
    
	@IBOutlet var lupaIcon: UIButton!
	@IBOutlet var searchBar2: UISearchBar!
	
	@IBOutlet var myMoviesCollectionView: UICollectionView!
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.transitioningDelegate = self
	
		myMoviesCollectionView.delegate = self
		myMoviesCollectionView.dataSource = self
		
		searchBar2.delegate = self
		searchBar2.isHidden = true
        
        if let data = UserDefaults.standard.data(forKey: "watchedMovies"),
            let MovieList = NSKeyedUnarchiver.unarchiveObject(with: data) as? [Movie] {
           self.watchedMovies = MovieList
        }
        DispatchQueue.main.async {
           self.myMoviesCollectionView.reloadData()
            
        }

        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	@IBAction func MoviesInTheaterPressed(_ sender: UIButton) {
		let moviesInTheaterViewController = storyboard!.instantiateViewController(withIdentifier: "MoviesInTheater") as! ViewController
		present(moviesInTheaterViewController, animated: true, completion: nil)

		moviesInTheaterViewController.transitioningDelegate = self
	}
	
//MARK: - SearchBar methods
	
    @IBAction func unwindToMyMovies(segue: UIStoryboardSegue){
        
        
        
    }
    
    
    func goToDescription(movie: Movie) {
        
        let main: UIStoryboard  = UIStoryboard.init(name: "Main", bundle: nil)
        let destination: DescriptionViewController = main.instantiateViewController(withIdentifier: "description") as! DescriptionViewController
        destination.movie = movie
        destination.viewIdentifier = "MyMoviesViewController"
        self.present(destination, animated: true, completion: nil)
        
    }
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.goToDescription(movie: nowPlayingMoviesModel.movieArray[indexPath.item + 1])
//    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.goToDescription(movie: watchedMovies[indexPath.section])
    }
    
    
    @IBAction func lupaIconPressed(_ sender: UIButton) {
		searchBar2.isHidden = false
		searchBar2.backgroundImage = UIImage()
		searchBar2.tintColor = UIColor.white
		lupaIcon.isHidden = true
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "search") as! SearchViewController
		secondViewController.searchText = searchBar.text
		self.goToSearch()
	}
	
	func goToSearch () {
		
		let main: UIStoryboard  = UIStoryboard.init(name: "Main", bundle: nil)
		let destination: SearchViewController = main.instantiateViewController(withIdentifier: "search") as! SearchViewController
		destination.searchText =  searchBar2.text

		self.present(destination, animated: true, completion: nil)
	}
	
	func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
		self.searchBar2.endEditing(true)
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		self.searchBar2.resignFirstResponder()
		self.searchBar2.isHidden = true
		lupaIcon.isHidden = false
	}
	
//MARK: - Collection view Methods
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return self.watchedMovies.count
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// Placeholder
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = myMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "myMovieCell", for: indexPath) as! MyMoviesCollectionViewCell
		
		cell.loadCell(cellMovie: watchedMovies[indexPath.section] )
		
		return cell
	}

}

extension MyMoviesViewController: UIViewControllerTransitioningDelegate {
	
	func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return transition
	}
	
	func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
		return nil
	}
}
