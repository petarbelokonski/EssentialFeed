//
//  FeedErrorViewModel.swift
//  EssentialFeediOS
//
//  Created by Petar Bel on 6.10.23.
//

import Foundation

public struct FeedErrorViewModel {
    let message: String?

    static var noError: FeedErrorViewModel {
        return FeedErrorViewModel(message: nil)
    }

    static func error(message: String) -> FeedErrorViewModel {
        return FeedErrorViewModel(message: message)
    }
}
