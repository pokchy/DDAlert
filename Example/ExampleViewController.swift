//
//  ExampleViewController.swift
//  Example
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit
import DDAlert

class ExampleViewController: UIViewController {

    @IBAction func showAlert(_ sender: UIButton) {
        let actions = [
            DDAlertAction(title: "Action 1", action: {
                print("Action 1")
            }),
            DDAlertAction(title: "Action 2", action: {
                print("Action 2")
            }),
            DDAlertAction(title: "Action 3", action: {
                print("Action 3")
            })
        ]

        var appearance = DDAlertAppearance()
        appearance.alertBackgroundColor = .yellow
        appearance.transparentBackgroundColor = .blue

        let alert = DDAlert(title: "Insert your title here", message: "Display a message for this alert. Something more", actions: actions, sourceObject: sender, appearance: appearance)
        alert.delegate = self
        present(alert, animated: true)
    }

    @IBAction func showAlertInMiddle(_ sender: Any) {
        let actions = [
            DDAlertAction(title: "Action 1", action: {
                print("Action 1")
            }),
            DDAlertAction(title: "Action 2", action: {
                print("Action 2")
            }),
            DDAlertAction(title: "Action 3", action: {
                print("Action 3")
            })
        ]
        let alert = DDAlert(title: "Insert your title here", message: "Display a message for this alert. Something more", actions: actions)
        alert.delegate = self
        present(alert, animated: true)
    }
}

extension ExampleViewController: DDAlertDelegate {

    func didDismissAlert(fromAction: DDAlertAction?) {
        print(fromAction?.title)
    }
}
