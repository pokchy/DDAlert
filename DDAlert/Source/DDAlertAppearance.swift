//
//  DDAlertAppearance.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

public struct DDAlertAppearance {

    public var transparentBackgroundColor = UIColor.gray.withAlphaComponent(0.3)
    public var shadowColor = UIColor.black
    public var alertBackgroundColor = UIColor.white
    public var alertTextColor = UIColor.black
    public var titleFont = UIFont.boldSystemFont(ofSize: 17)
    public var messageFont = UIFont.systemFont(ofSize: 17)

    public init() { }
}
