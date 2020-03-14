//
//  DDAlertView.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal final class DDAlertView: UIView {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var messageLabel: UILabel!
    @IBOutlet private weak var actionsStackView: UIStackView!

    internal init(title: String? = nil, message: String? = nil, actions: [DDAlertAction], appearance: DDAlertAppearance, delegate: DDAlertButtonDelegate?) {
        super.init(frame: .zero)
        loadView()
        titleLabel.text = title
        titleLabel.font = appearance.titleFont
        titleLabel.textColor = appearance.alertTextColor
        messageLabel.text = message
        messageLabel.font = appearance.messageFont
        messageLabel.textColor = appearance.alertTextColor
        backgroundColor = appearance.alertBackgroundColor
        actions.forEach { action in
            let button = DDAlertButton(title: action.title, appearance: action.appearance, action: action.action)
            button.delegate = delegate
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
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}
