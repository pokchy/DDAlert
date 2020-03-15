//
//  UIView+Position.swift
//  DDAlert
//
//  Created by Thanh Duc Do on 15.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit

internal enum CenterPositionInScreen {
    case center
    case upperHorizontalAligned
    case upperRight
    case rightVerticalAligned
    case lowerRight
    case lowerHorizontalAligned
    case lowerLeft
    case leftVerticalAligned
    case upperLeft
}

internal extension UIView {

    var relativeCenterPositionInScreen: CenterPositionInScreen? {
        let screenCenterX = UIScreen.main.bounds.width / 2
        let screenCenterY = UIScreen.main.bounds.height / 2
        let isAroundYAxis = abs(center.x - screenCenterX) < 1
        let isAroundXAxis = abs(center.y - screenCenterY) < 1

        if isAroundYAxis, abs(center.y - screenCenterY) < 1 {
            return .center
        } else if center.y < screenCenterY, isAroundYAxis {
            return .upperHorizontalAligned
        } else if center.y > screenCenterY, isAroundYAxis {
            return .lowerHorizontalAligned
        } else if center.x > screenCenterX, isAroundXAxis {
            return .rightVerticalAligned
        } else if center.x < screenCenterX, isAroundXAxis {
            return .leftVerticalAligned
        } else if center.y < screenCenterY, center.x > screenCenterX {
            return .upperRight
        } else if center.y < screenCenterY, center.x < screenCenterX {
            return .upperLeft
        } else if center.y > screenCenterY, center.x > screenCenterX {
            return .lowerRight
        } else if center.y > screenCenterY, center.x < screenCenterX {
            return .lowerLeft
        }
        return nil
    }
}
