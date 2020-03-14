//
//  SimpleViewController.swift
//  Example
//
//  Created by Thanh Duc Do on 14.03.20.
//  Copyright © 2020 Thanh Duc Do. All rights reserved.
//

import UIKit
import DDAlert

class SimpleViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton()
        button.setTitle("Show alert", for: .normal)
        button.addTarget(self, action: #selector(showAlert), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func showAlert() {
        let actions = [
            DDAlertAction(title: "Action 1", action: {
                print("Hello action 1")
            }),
            DDAlertAction(title: "Action 2", action: {
                print("Hello action 2")
            }),
            DDAlertAction(title: "Action 3", action: {
                print("Hello action 3")
            })
        ]
        let alert = DDAlert(title: "Hello", message: "World", actions: actions)
        present(alert, animated: true)
    }
}
