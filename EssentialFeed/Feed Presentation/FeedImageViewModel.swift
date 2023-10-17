//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Petar Bel on 7.10.23.
//

import Foundation

public struct FeedImageViewModel {
    public let description: String?
    public let location: String?

    public var hasLocation: Bool {
        return location != nil
    }
}
