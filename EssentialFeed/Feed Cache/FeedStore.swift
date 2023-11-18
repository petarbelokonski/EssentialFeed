//
//  FeedStore.swift
//  EssentialFeed
//
//  Created by Petar Bel on 3.04.23.
//

import Foundation

public struct CachedFeed {
    public let feed: [LocalFeedImage]
    public let timestamp: Date

    public init(feed: [LocalFeedImage], timestamp: Date) {
        self.feed = feed
        self.timestamp = timestamp
    }
}

public protocol FeedStore {
    func deleteCacheFeed() throws

    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws

    func retrieve() throws -> CachedFeed?
}
