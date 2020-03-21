//
//  DDAlert.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

public protocol DDAlertDelegate: AnyObject {
    /// Delegate function is triggered when alert was dismissed
    /// - Parameter fromIndex: Index of action when DDAlert was dismissed by pressing an action. Otherwise nil.
    func didDismissAlert(fromIndex: Int?)
}

/// Customizable alert
public final class DDAlert: UIViewController {

    private var alertTitle: String?
    private var alertMessage: String?
    private var actions: [DDAlertAction]
    internal var sourceView: UIView? {
        guard let object = sourceObject else { return nil }
        if let view = object as? UIView {
            return view
        }
        return nil
    }

    internal lazy var alertView: DDAlertView = {
        let alertView = DDAlertView(title: alertTitle, message: alertMessage, customViews: customViews, actions: actions, appearance: appearance, delegate: self)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()

    /// Alert will try to position itsself relatively to this object
    public weak var sourceObject: AnyObject?
    /// Cusomize the alert
    public var appearance: DDAlertAppearance
    /// Custom UIViews to be displayed between message label and actions
    public private(set) var customViews = [UIView]()
    public weak var delegate: DDAlertDelegate?

    /// DDAlert initializer
    /// - Parameters:
    ///   - title: Title to be displayed. Default is nil
    ///   - message: Message to be displayed. Default is nil
    ///   - actions: Array of DDAlertAction to trigger actions
    ///   - sourceObject: Object to determine location of DDAlert. Default is nil
    ///   - appearance: Appearance to customize DDAlert
    public init(title: String? = nil, message: String? = nil, actions: [DDAlertAction] = [], sourceObject: AnyObject? = nil, appearance: DDAlertAppearance = DDAlertAppearance()) {
        self.sourceObject = sourceObject
        self.appearance = appearance
        self.alertTitle = title
        self.alertMessage = message
        self.actions = actions
        super.init(nibName: String(describing: DDAlert.self), bundle: Bundle(for: DDAlert.self))
        modalPresentationStyle = .overCurrentContext
        transitioningDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = appearance.transparentBackgroundColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissAlert))
        tapRecognizer.delegate = self
        view.addGestureRecognizer(tapRecognizer)
        view.addSubview(alertView)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        alertView.layer.shadowPath = UIBezierPath(rect: alertView.bounds).cgPath
        alertView.layer.shadowColor = appearance.shadowColor.cgColor
        alertView.layer.shadowOpacity = appearance.shadowOpacity
        alertView.layer.shadowOffset = .zero
        alertView.layer.shadowRadius = appearance.shadowRadius
        positionAlertView()
    }

    /// Add an action to the alert
    /// - Parameter action: Action to be added
    public func addAction(_ action: DDAlertAction) {
        actions.append(action)
    }

    /// Add a custom view  between message label and buttons
    /// - Parameter view: view to be displayed
    public func addCustomView(_ view: UIView) {
        customViews.append(view)
    }

    @objc internal func dismissAlert() {
        dismiss(animated: true) {
            self.delegate?.didDismissAlert(fromIndex: nil)
        }
    }

    @objc private func keyboardWillShow(notification: Notification) {
        guard
            let duration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue,
            let endKeyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height else {
                return
        }
        UIView.animate(withDuration: duration, animations: {
            self.alertView.frame = CGRect(x: self.view.center.x - (self.alertView.frame.width / 2), y: UIScreen.main.bounds.height - (self.alertView.frame.height + endKeyboardHeight + 20), width: self.alertView.frame.width, height: self.alertView.frame.height)
        })
    }

    private func positionAlertView() {
        if let sourceView = sourceView, let relativePosition = sourceView.relativeCenterPositionInScreen {
            switch relativePosition {
            case .center:
                alertView.center = view.center
            case .upperHorizontalAligned:
                alertView.layer.anchorPoint = CGPoint(x: 0.5, y: 0)
                alertView.frame = CGRect(x: sourceView.center.x - (alertView.frame.width / 2), y: sourceView.center.y, width: alertView.frame.width, height: alertView.frame.height)
            case .upperRight:
                alertView.layer.anchorPoint = CGPoint(x: 1, y: 0)
                alertView.frame = CGRect(x: sourceView.center.x - alertView.frame.width, y: sourceView.center.y, width: alertView.frame.width, height: alertView.frame.height)
            case .rightVerticalAligned:
                alertView.layer.anchorPoint = CGPoint(x: 1, y: 0.5)
                alertView.frame = CGRect(x: sourceView.center.x - alertView.frame.width, y: sourceView.center.y - (alertView.frame.height / 2), width: alertView.frame.width, height: alertView.frame.height)
            case .lowerRight:
                alertView.layer.anchorPoint = CGPoint(x: 1, y: 1)
                alertView.frame = CGRect(x: sourceView.center.x - alertView.frame.width, y: sourceView.center.y - alertView.frame.height, width: alertView.frame.width, height: alertView.frame.height)
            case .lowerHorizontalAligned:
                alertView.layer.anchorPoint = CGPoint(x: 0.5, y: 1)
                alertView.frame = CGRect(x: sourceView.center.x - (alertView.frame.width / 2), y: sourceView.center.y - alertView.frame.height, width: alertView.frame.width, height: alertView.frame.height)
            case .lowerLeft:
                alertView.layer.anchorPoint = CGPoint(x: 0, y: 1)
                alertView.frame = CGRect(x: sourceView.center.x, y: sourceView.center.y - alertView.frame.height, width: alertView.frame.width, height: alertView.frame.height)
            case .leftVerticalAligned:
                alertView.layer.anchorPoint = CGPoint(x: 0, y: 0.5)
                alertView.frame = CGRect(x: sourceView.center.x, y: sourceView.center.y - (alertView.frame.height / 2), width: alertView.frame.width, height: alertView.frame.height)
            case .upperLeft:
                alertView.layer.anchorPoint = CGPoint(x: 0, y: 0)
                alertView.frame = CGRect(x: sourceView.center.x, y: sourceView.center.y, width: alertView.frame.width, height: alertView.frame.height)
            }
        } else {
            alertView.center = view.center
        }
    }
}

extension DDAlert: UIGestureRecognizerDelegate {
    /// Implemented UIGestureRecognizerDelegate to trigger dismissal of DDAlert
    /// - Parameters:
    ///   - gestureRecognizer: UIGestureRecognizer
    ///   - touch: UITouch
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension DDAlert: DDAlertButtonDelegate {
    func buttonPressed(index: Int) {
        dismiss(animated: true) {
            self.delegate?.didDismissAlert(fromIndex: index)
        }
    }
}

extension DDAlert: UIViewControllerTransitioningDelegate {
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DDAlertAnimatedTransitioning()
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return DDAlertAnimatedTransitioning()
    }
}
