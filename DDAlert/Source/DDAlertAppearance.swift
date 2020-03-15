//
//  DDAlertAppearance.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

/// Appearance object to customize DDAlert
public struct DDAlertAppearance {

    /// Color of transparent background. Default is UIColor.clear.
    public var transparentBackgroundColor = UIColor.clear
    /// Shadow color. Default is UIColor.black.
    public var shadowColor = UIColor.black
    /// Shadow opacity. Default is 0.3.
    public var shadowOpacity: Float = 0.3
    /// Shadow radius. Default is 10.
    public var shadowRadius: CGFloat = 10
    /// Background color of DDAlert. Default is UIColor.white
    public var alertBackgroundColor = UIColor.white
    /// Text color of title and message in DDAlert. Default is UIColor.black
    public var alertTextColor = UIColor.black
    /// Title font in DDAlert. Default is bold system font with size 17
    public var titleFont = UIFont.boldSystemFont(ofSize: 17)
    /// Message font in DDAlert. Default is system font with size 17
    public var messageFont = UIFont.systemFont(ofSize: 17)

    public init() { }
}
