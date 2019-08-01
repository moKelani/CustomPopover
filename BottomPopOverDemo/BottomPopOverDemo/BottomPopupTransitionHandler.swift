//
//  BottomPopupTransitionHandler.swift
//  MedicalEmpire
//
//  Created by Mohamed Kelany on 11/23/18.
//  Copyright © 2018 Ramy Nasser. All rights reserved.
//

import UIKit

class BottomPopupTransitionHandler: NSObject, UIViewControllerTransitioningDelegate {
    
    private var presentAnimator: BottomPopupPresentAnimator!
    private var dismissAnimator: BottomPopupDismissAnimator!
    private var interactionController: BottomPopupDismissInteractionController?
    private unowned var popupViewController: BottomPresentableViewController
    fileprivate weak var popupDelegate: BottomPopupDelegate?
    
    var isInteractiveDismissStarted = false
    
    init(popupViewController: BottomPresentableViewController) {
        self.popupViewController = popupViewController
        
        presentAnimator = BottomPopupPresentAnimator(attributesOwner: popupViewController)
        dismissAnimator = BottomPopupDismissAnimator(attributesOwner: popupViewController)
    }
    
    //MARK: Public
    func notifyViewLoaded(withPopupDelegate delegate: BottomPopupDelegate?) {
        self.popupDelegate = delegate
        if popupViewController.shouldPopupDismissInteractivelty() {
            interactionController = BottomPopupDismissInteractionController(presentedViewController: popupViewController)
            interactionController?.delegate = self
        }
    }
    
    //MARK: Specific animators
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return BottomPopupPresentationController(presentedViewController: presented, presenting: presenting, usingHeight: popupViewController.getPopupHeight(), andDimmingViewAlpha: popupViewController.getDimmingViewAlpha())
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimator
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return dismissAnimator
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return isInteractiveDismissStarted ? interactionController : nil
    }
}

extension BottomPopupTransitionHandler: BottomPopupDismissInteractionControllerDelegate {
    func dismissInteractionPercentChanged(from oldValue: CGFloat, to newValue: CGFloat) {
        popupDelegate?.bottomPopupDismissInteractionPercentChanged(from: oldValue, to: newValue)
    }
}
