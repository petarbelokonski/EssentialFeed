//
//  UIButton+TestHelpers.swift
//  EssentialFeediOSTests
//
//  Created by Petar Bel on 9.09.23.
//

import UIKit

extension UIButton {
    func simulateTap() {
        simulate(event: .touchUpInside)
    }
}
