//
//  DDAlertAction.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

/// Initialize your action for DDAlert
public struct DDAlertAction {

    internal var title: String
    internal var action: (() -> Void)?

    /// Appearance object to customize DDAlertAction
    public var appearance: DDAlertActionAppearance

    /// Initializer
    /// - Parameters:
    ///   - title: Title of DDAlertAction
    ///   - appearance: Appearance object to customize DDAlertAction
    ///   - action: Action to be triggered
    public init(title: String, appearance: DDAlertActionAppearance = DDAlertActionAppearance(), action: (() -> Void)? = nil) {
        self.title = title
        self.appearance = appearance
        self.action = action
    }
}
