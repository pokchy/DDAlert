//
//  DDAlertButton.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal protocol DDAlertButtonDelegate: AnyObject {
    func buttonPressed()
}

internal final class DDAlertButton: UIButton {

    private var action: (() -> Void)?
    internal weak var delegate: DDAlertButtonDelegate?

    public init(title: String = "", appearance: DDAlertActionAppearance, action: (() -> Void)? = nil) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        backgroundColor = appearance.backgroundColor
        titleLabel?.font = appearance.titleFont
        setTitleColor(appearance.textColor, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 16)
        self.action = action
        addTarget(self, action: #selector(triggerAction), for: .touchUpInside)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func triggerAction() {
        action?()
        delegate?.buttonPressed()
    }
}
