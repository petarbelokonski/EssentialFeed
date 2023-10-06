//
//  UIRefreshControl+Helpers.swift
//  EssentialFeediOS
//
//  Created by Petar Bel on 6.10.23.
//

import UIKit

extension UIRefreshControl {
    func update(isRefreshing: Bool) {
        isRefreshing ? beginRefreshing() : endRefreshing()
    }
}
