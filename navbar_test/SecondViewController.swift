//
//  SecondViewController.swift
//  navbar_test
//
//  Created by kenmaz on 2019/07/01.
//  Copyright © 2019 net.kenmaz. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController, ThemedNavBarController {

    var originalTheme: NavBarTheme?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View2"

        guard let navBar = navigationController?.navigationBar, let barTint = navBar.barTintColor else { return }
        originalTheme = NavBarTheme(tintColor: navBar.tintColor, backgroundColor: barTint, attributes: navBar.titleTextAttributes, barStyle: navBar.barStyle)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //hack
        if isMovingToParent {
            applyCustomTheme()
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //hack
        if !isMovingToParent {
            applyCustomTheme()
        }
    }

    private func applyCustomTheme() {
        guard var attr = originalTheme?.titleAttributes else { return }
        attr[NSAttributedString.Key.foregroundColor] = UIColor.white
        guard let style = originalTheme?.barStyle else { return }
        applyCustomTheme(theme: NavBarTheme(tintColor: UIColor.white, backgroundColor: UIColor.black, attributes: attr, barStyle: style))
    }

    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        if parent == nil {
            restoreOriginalTheme()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        restoreOriginalTheme()
    }
}
