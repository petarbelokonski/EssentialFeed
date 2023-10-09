//
//  UIView+TestHelpers.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 9.10.23.
//

import UIKit

extension UIView {
    func enforceLayoutCycle() {
        layoutIfNeeded()
        RunLoop.current.run(until: Date())
    }
}
