//
//  TransitionAnimator.swift
//  MovieDB - Nano Challenge
//
//  Created by Athos Lagemann on 05/06/17.
//  Copyright © 2017 nano Challenge Movie DB. All rights reserved.
//

import UIKit

class TransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
	
	let duration = 0.001
	var presenting = true
	var originFrame = CGRect.zero

	func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
		return TimeInterval(duration)
	}
	
	func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
		let containerView = transitionContext.containerView
		let toView = transitionContext.view(forKey: .to)
		
		containerView.addSubview(toView!)
		toView?.alpha = 0.0
		
		UIView.animate(withDuration: TimeInterval(duration), animations: {
			toView?.alpha = 1.0
		}, completion: { _ in transitionContext.completeTransition(true)
			}
		)
	}
	
}
