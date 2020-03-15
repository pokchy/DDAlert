//
//  DDAlertAnimatedTransitioning.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 15.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal class DDAlertAnimatedTransitioning: NSObject, UIViewControllerAnimatedTransitioning {

    private let duration = 0.3

    // MARK: - UIViewControllerAnimatedTransitioning

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if
            let presentingAlert = transitionContext.viewController(forKey: .to) as? DDAlert,
            let presentingView = transitionContext.view(forKey: .to) {
                presentingAlert.view.alpha = 0
                presentingAlert.alertView.alpha = 0
                presentingAlert.alertView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
                let containerView = transitionContext.containerView
                presentingView.frame = containerView.frame
                containerView.addSubview(presentingView)
        } else if let presentedView = transitionContext.view(forKey: .from) {
            let containerView = transitionContext.containerView
            presentedView.frame = containerView.frame
            containerView.addSubview(presentedView)
        }

        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseInOut, animations: {
            if let presentingAlert = transitionContext.viewController(forKey: .to) as? DDAlert {
                presentingAlert.view.alpha = 1
                presentingAlert.alertView.alpha = 1
                presentingAlert.alertView.transform = .identity
            } else if let presentedAlert = transitionContext.viewController(forKey: .from) as? DDAlert {
                presentedAlert.view.alpha = 0
                presentedAlert.alertView.alpha = 0
                presentedAlert.alertView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
            }
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
