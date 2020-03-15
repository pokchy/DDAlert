//
//  DDAlertButton.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal protocol DDAlertButtonDelegate: AnyObject {
    func buttonPressed(action: DDAlertAction)
}

internal final class DDAlertButton: UIButton {

    internal let alertAction: DDAlertAction
    internal weak var delegate: DDAlertButtonDelegate?

    init(action alertAction: DDAlertAction) {
        self.alertAction = alertAction
        super.init(frame: .zero)
        setTitle(alertAction.title, for: .normal)
        backgroundColor = alertAction.appearance.backgroundColor
        titleLabel?.font = alertAction.appearance.titleFont
        setTitleColor(alertAction.appearance.textColor, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        addTarget(self, action: #selector(triggerAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func triggerAction() {
        alertAction.action?()
        delegate?.buttonPressed(action: alertAction)
    }
}
