//
//  DDAlert.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

@objc public protocol DDAlertDelegate: AnyObject {
    @objc optional func didDismissAlert()
}

public final class DDAlert: UIViewController {

    private weak var sourceObject: AnyObject?
    private var appearance: DDAlertAppearance
    private var alertTitle: String?
    private var alertMessage: String?
    private var actions: [DDAlertAction]
    private var sourceView: UIView? {
        guard let object = sourceObject else { return nil }
        if let view = object as? UIView {
            return view
        }
        if let barButtonItem = object as? UIBarButtonItem, let view = barButtonItem.value(forKey: "view") as? UIView {
            return view
        }
        return nil
    }

    private lazy var alertView: DDAlertView = {
        let alertView = DDAlertView(title: alertTitle, message: alertMessage, actions: actions, appearance: appearance, delegate: self)
        alertView.translatesAutoresizingMaskIntoConstraints = false
        return alertView
    }()

    public weak var delegate: DDAlertDelegate?

    public init(title: String? = nil, message: String? = nil, actions: [DDAlertAction], sourceObject: AnyObject? = nil, appearance: DDAlertAppearance = DDAlertAppearance()) {
        self.sourceObject = sourceObject
        self.appearance = appearance
        self.alertTitle = title
        self.alertMessage = message
        self.actions = actions
        super.init(nibName: String(describing: DDAlert.self), bundle: Bundle(for: DDAlert.self))
        modalPresentationStyle = .overCurrentContext
        modalTransitionStyle = .crossDissolve
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
    }

    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showAlertInCenter()
    }

    @objc private func dismissAlert() {
        UIView.animate(withDuration: 0.3, animations: {
            self.alertView.transform = CGAffineTransform.identity.scaledBy(x: 0.3, y: 0.3)
            self.alertView.alpha = 0
            self.view.backgroundColor = .clear
        }) { _ in
            self.dismiss(animated: false) {
                self.delegate?.didDismissAlert?()
            }
        }
    }

    private func showAlertInCenter() {
        NSLayoutConstraint.activate([
            alertView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            alertView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        showAlert()
    }

    // WIP
    private func showAlertRelative(to sourceView: UIView) {
        alertView.layer.anchorPoint = CGPoint(x: 1, y: 1)
        alertView.layer.position = sourceView.center
        showAlert()
    }

    private func showAlert() {
        alertView.transform = CGAffineTransform.identity.scaledBy(x: 0, y: 0)
        alertView.alpha = 0
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.alertView.transform = .identity
            self.alertView.alpha = 1
        })
    }
}

extension DDAlert: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == gestureRecognizer.view
    }
}

extension DDAlert: DDAlertButtonDelegate {
    func buttonPressed() {
        dismissAlert()
    }
}
