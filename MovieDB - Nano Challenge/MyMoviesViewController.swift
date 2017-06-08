//
//  MyMoviesViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MyMoviesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
	
	let transition = TransitionAnimator()
	
	@IBOutlet var myMoviesCollectionView: UICollectionView!
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.transitioningDelegate = self
	
		myMoviesCollectionView.delegate = self
		myMoviesCollectionView.dataSource = self
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
	
	// Collection view Methods
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		// Placeholder
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = myMoviesCollectionView.dequeueReusableCell(withReuseIdentifier: "myMovieCell", for: indexPath) as! MyMoviesCollectionViewCell
		
		cell.loadCell()
		
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
