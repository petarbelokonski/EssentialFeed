//
//  LocalFeedLoader.swift
//  EssentialFeed
//
//  Created by Petar Bel on 3.04.23.
//

import Foundation

public final class LocalFeedLoader {
    private let store: FeedStore
    private let currentDate: () -> Date 

    public init(store: FeedStore, currentDate: @escaping () -> Date) {
        self.store = store
        self.currentDate = currentDate
    }

    private func isValid(cache: CachedFeed) -> Bool {
        FeedCachePolicy.validate(cache.timestamp, against: currentDate())
    }
}

extension LocalFeedLoader: FeedCache {
    public func save(_ feed: [FeedImage]) throws {
        try store.deleteCacheFeed()
        try cache(feed)
    }

    private func cache(_ feed: [FeedImage]) throws {
        try store.insert(feed.toLocal(), timestamp: currentDate())
    }
}

extension LocalFeedLoader {
    public func load() throws -> [FeedImage] {
        if let cache = try store.retrieve(), isValid(cache: cache) {
            return cache.feed.toModels()
        }
        return []
    }
}

extension LocalFeedLoader {
    private struct InvalidCache: Error {}

    public func validateCache() throws {
        do {
            if let cache = try store.retrieve(), !isValid(cache: cache) {
                throw InvalidCache()
            }
        } catch {
            try store.deleteCacheFeed()
        }
    }
}

private extension Array where Element == FeedImage {
    func toLocal() -> [LocalFeedImage] {
        return map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
}

private extension Array where Element == LocalFeedImage {
    func toModels() -> [FeedImage] {
        return map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    }
}
