//
//  DDAlertAction.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

public struct DDAlertAction {
    public var title: String
    public var appearance: DDAlertActionAppearance
    public var action: (() -> Void)?

    public init(title: String, appearance: DDAlertActionAppearance = DDAlertActionAppearance(), action: (() -> Void)? = nil) {
        self.title = title
        self.appearance = appearance
        self.action = action
    }
}
