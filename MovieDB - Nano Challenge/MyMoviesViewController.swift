//
//  MyMoviesViewController.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class MyMoviesViewController: UIViewController {
	
	let transition = TransitionAnimator()
	
	override var preferredStatusBarStyle: UIStatusBarStyle {
		return .lightContent
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.transitioningDelegate = self
        // Do any additional setup after loading the view.
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
	@IBAction func MoviesInTheaterPressed(_ sender: UIButton) {
		let moviesInTheaterViewController = storyboard!.instantiateViewController(withIdentifier: "MoviesInTheater") as! ViewController
		present(moviesInTheaterViewController, animated: true, completion: nil)

		moviesInTheaterViewController.transitioningDelegate = self
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
