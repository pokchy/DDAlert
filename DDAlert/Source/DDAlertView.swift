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
        actionsStackView.axis = actions.count == 2 ? .horizontal : .vertical
        actions.forEach { action in
            let button = DDAlertButton(action: action)
            button.delegate = delegate
            button.addConstraint(NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 40))
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
