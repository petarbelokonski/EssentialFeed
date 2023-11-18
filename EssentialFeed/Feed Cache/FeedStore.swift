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
    typealias DeletionResult = Result<Void, Error>
    typealias DeletionCompletion = (DeletionResult) -> Void

    typealias InsertionResult = Result<Void, Error>
    typealias InsertionCompletion = (InsertionResult) -> Void

    typealias RetrievalResult = Result<CachedFeed?, Error>
    typealias RetrievalCompletion = (RetrievalResult) -> Void

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @available(*, deprecated)
    func deleteCacheFeed(completion: @escaping DeletionCompletion)

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @available(*, deprecated)
    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion)

    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    @available(*, deprecated)
    func retrieve(completion: @escaping RetrievalCompletion)

    func deleteCacheFeed() throws

    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws

    func retrieve() throws -> CachedFeed?
}

public extension FeedStore {
    func deleteCacheFeed() throws {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var result: DeletionResult!
        deleteCacheFeed {
            result = $0
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        try result.get()
    }

    func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var result: InsertionResult!
        insert(feed, timestamp: timestamp) {
            result = $0
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        try result.get()
    }

    func retrieve() throws -> CachedFeed? {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var result: RetrievalResult!
        retrieve {
            result = $0
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        return try result.get()
    }

    func deleteCacheFeed(completion: @escaping DeletionCompletion) {
    }

    func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {
    }

    func retrieve(completion: @escaping RetrievalCompletion) {
    }
}
