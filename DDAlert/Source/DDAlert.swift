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

    private weak var sourceView: AnyObject?
    private var appearance: DDAlertAppearance
    private var alertTitle: String?
    private var alertMessage: String?
    private var actions: [DDAlertAction]

    public weak var delegate: DDAlertDelegate?

    public init(title: String? = nil, message: String? = nil, actions: [DDAlertAction], sourceView: AnyObject? = nil, appearance: DDAlertAppearance = DDAlertAppearance()) {
        self.sourceView = sourceView
        self.appearance = appearance
        self.alertTitle = title
        self.alertMessage = message
        self.actions = actions
        super.init(nibName: String(describing: DDAlert.self), bundle: Bundle(for: DDAlert.self))
        modalPresentationStyle = .overCurrentContext
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

        let view = DDAlertView(title: alertTitle, message: alertMessage, actions: actions, appearance: appearance, delegate: self)
        view.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(view)
        NSLayoutConstraint.activate([
            view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        ])
    }

    @objc private func dismissAlert() {
        dismiss(animated: true) {
            self.delegate?.didDismissAlert?()
        }
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
