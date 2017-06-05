//
//  ViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Henrique Jordão on 02/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

	@IBOutlet var mainCollectionView: UICollectionView!
	@IBOutlet var MyMoviesButton: UIButton!
	
	let transition = TransitionAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.transitioningDelegate = self
		mainCollectionView.delegate = self
		mainCollectionView.dataSource = self
		mainCollectionView.prefetchDataSource = self
		
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
		return 3
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = mainCollectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MainScreenCollectionViewCell
		
		cell.loadDefaultImg()
		
		return cell
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








