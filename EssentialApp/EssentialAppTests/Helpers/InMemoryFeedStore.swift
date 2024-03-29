//
//  InMemoryFeedStore.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 2.10.23.
//

import Foundation
import EssentialFeed

final class InMemoryFeedStore: FeedStore, FeedImageDataStore {
    private(set) var feedCache: CachedFeed?
    private var feedImageDataCache: [URL: Data] = [:]

    private init(feedCache: CachedFeed? = nil) {
        self.feedCache = feedCache
    }

    func deleteCacheFeed() throws {
        feedCache = nil
    }

    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        feedCache = CachedFeed(feed: feed, timestamp: timestamp)
    }

    func retrieve() throws -> CachedFeed? {
        feedCache
    }

    func insert(_ data: Data, for url: URL) throws {
        feedImageDataCache[url] = data
    }

    func retrieve(dataForURL url: URL) throws -> Data? {
        feedImageDataCache[url]
    }

    static var empty: InMemoryFeedStore {
        InMemoryFeedStore()
    }

    static var withExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date.distantPast))
    }

    static var withNonExpiredFeedCache: InMemoryFeedStore {
        InMemoryFeedStore(feedCache: CachedFeed(feed: [], timestamp: Date()))
    }
}
