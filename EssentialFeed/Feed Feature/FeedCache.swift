//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Petar Bel on 29.09.23.
//

import Foundation

public protocol FeedCache {
    func save(_ feed: [FeedImage]) throws
}
