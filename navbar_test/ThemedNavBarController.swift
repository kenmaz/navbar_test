//
//  ThemedNavBarController.swift
//  MerpayCoreKit
//
//  Created by aj.rodriguez on 2019/05/20.
//  Copyright © 2019 merpay, Inc. All rights reserved.
//

import UIKit

public struct NavBarTheme {
    let tintColor: UIColor
    let backgroundColor: UIColor
    var titleAttributes: [NSAttributedString.Key: Any]?
    var barStyle: UIBarStyle
    public init(tintColor: UIColor, backgroundColor: UIColor, attributes: [NSAttributedString.Key: Any]?, barStyle: UIBarStyle) {
        self.tintColor = tintColor
        self.backgroundColor = backgroundColor
        self.titleAttributes = attributes
        self.barStyle = barStyle
    }
}

public protocol ThemedNavBarController {
    var originalTheme: NavBarTheme? { get set }
}

extension ThemedNavBarController where Self: UIViewController {
    public func applyCustomTheme(theme: NavBarTheme) {
        var attributes: [NSAttributedString.Key: Any] = [:]
        if let originalAttributes = navigationController?.navigationBar.titleTextAttributes {
            originalAttributes.forEach { (key, value) in
                attributes[key] = value
            }
        }
        if let themeAttributes = theme.titleAttributes {
            themeAttributes.forEach { (key, value) in
                attributes[key] = value
            }
        }
        navigationController?.navigationBar.tintColor = theme.tintColor
        navigationController?.navigationBar.barTintColor = theme.backgroundColor
        navigationController?.navigationBar.titleTextAttributes = attributes
        navigationController?.navigationBar.barStyle = theme.barStyle
    }

    public func restoreOriginalTheme() {
        if let originalTheme = originalTheme {
            navigationController?.navigationBar.tintColor = originalTheme.tintColor
            navigationController?.navigationBar.barTintColor = originalTheme.backgroundColor
            navigationController?.navigationBar.titleTextAttributes = originalTheme.titleAttributes
            navigationController?.navigationBar.barStyle = originalTheme.barStyle
        }
    }
}
