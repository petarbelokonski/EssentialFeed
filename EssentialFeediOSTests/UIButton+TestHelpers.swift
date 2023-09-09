//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Petar Bel on 9.09.23.
//

import UIKit

extension UIButton {
    func simulateTap() {
        allTargets.forEach { target in
            actions(forTarget: target, forControlEvent: .touchUpInside)?.forEach {
                (target as NSObject).perform(Selector($0))
            }
        }
    }
}
