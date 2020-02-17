//
//  BounceAnimator.swift
//  ASA
//
//  Created by Infosys on 1/17/19.
//  Copyright © 2019 Infosys. All rights reserved.
//

import Foundation
import UIKit

class BounceAnimator: NSObject, UIViewControllerAnimatedTransitioning{
    
    let duration = 1.0
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        print("container",containerView)
        let toView = transitionContext.view(forKey: .to)!
        let imageView = toView
        containerView.addSubview(toView)
        containerView.bringSubview(toFront: imageView)
        UIView.animate(withDuration: duration, animations: {
            imageView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
        }, completion: { (finish) in
            UIView.animate(withDuration: self.duration, animations: {
                imageView.transform = CGAffineTransform.identity
            })
        })
    }
    
}
