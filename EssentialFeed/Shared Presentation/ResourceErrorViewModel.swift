//
//  FeedErrorViewModel.swift
//  EssentialFeed
//
//  Created by Petar Bel on 6.10.23.
//

import Foundation

public struct ResourceErrorViewModel {
    public let message: String?

    static var noError: ResourceErrorViewModel {
        return ResourceErrorViewModel(message: nil)
    }

    static func error(message: String) -> ResourceErrorViewModel {
        return ResourceErrorViewModel(message: message)
    }
}
