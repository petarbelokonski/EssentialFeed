//
//  UITableView+Dequeueing.swift
//  EssentialFeediOS
//
//  Created by Petar Bel on 13.09.23.
//

import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>() -> T {
        let identifier = String(describing: T.self)
        return dequeueReusableCell(withIdentifier: identifier) as! T
    }
}
