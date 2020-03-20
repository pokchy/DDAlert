//
//  DDAlertView.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal final class DDAlertView: UIView {

    @IBOutlet internal weak var titleLabel: UILabel!
    @IBOutlet internal weak var messageLabel: UILabel!
    @IBOutlet internal weak var actionsStackView: UIStackView!
    @IBOutlet private weak var separatorView: UIView!

    private var appearance: DDAlertAppearance

    internal init(title: String? = nil, message: String? = nil, actions: [DDAlertAction], appearance: DDAlertAppearance, delegate: DDAlertButtonDelegate?) {
        self.appearance = appearance
        super.init(frame: .zero)
        loadView()
        titleLabel.text = title
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.alertTextColor
        messageLabel.text = message
        messageLabel.font = appearance.messageFont
        messageLabel.textColor = appearance.alertTextColor
        separatorView.backgroundColor = appearance.separatorColor
        actionsStackView.axis = actions.count == 2 ? .horizontal : .vertical
        let removedSubviews = actionsStackView.arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            actionsStackView.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }
        NSLayoutConstraint.deactivate(removedSubviews.flatMap { $0.constraints })
        removedSubviews.forEach { $0.removeFromSuperview() }
        actions.enumerated().forEach { index, action in
            if actionsStackView.arrangedSubviews.count > 0 {
                let separator = UIView()
                separator.widthAnchor.constraint(equalToConstant: 1).isActive = actionsStackView.axis == .horizontal
                separator.heightAnchor.constraint(equalToConstant: 1).isActive = actionsStackView.axis == .vertical
                separator.backgroundColor = appearance.separatorColor
                actionsStackView.addArrangedSubview(separator)
                separator.heightAnchor.constraint(equalTo: actionsStackView.heightAnchor).isActive = actionsStackView.axis == .horizontal
                separator.widthAnchor.constraint(equalTo: actionsStackView.widthAnchor).isActive = actionsStackView.axis == .vertical
            }
            let button = DDAlertButton(action: action)
            button.tag = index
            button.delegate = delegate
            button.heightAnchor.constraint(equalToConstant: 44).isActive = true
            button.widthAnchor.constraint(greaterThanOrEqualToConstant: 120).isActive = true
            actionsStackView.addArrangedSubview(button)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func loadView() {
        guard let contentView = Bundle(for: DDAlertView.self).loadNibNamed(String(describing: DDAlertView.self), owner: self, options: nil)?.first as? UIView else {
            fatalError("Could not load DDAlertView")
        }
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = appearance.alertBackgroundColor
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
