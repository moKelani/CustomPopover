//
//  BottomPopupDismissAnimator.swift
//  MedicalEmpire
//
//  Created by Mohamed Kelany on 11/23/18.
//  Copyright © 2018 Ramy Nasser. All rights reserved.
//


import UIKit

class BottomPopupDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    private unowned var attributesOwner: BottomPresentableViewController
    
    init(attributesOwner: BottomPresentableViewController) {
        self.attributesOwner = attributesOwner
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return attributesOwner.getPopupDismissDuration()
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: .from)!
        let dismissFrame = CGRect(origin: CGPoint(x: 0, y: UIScreen.main.bounds.size.height), size: fromVC.view.frame.size)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            fromVC.view.frame = dismissFrame
        }) { (_) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
