//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Petar Bel on 29.09.23.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ feed: [FeedImage]) throws

    @available(*, deprecated)
    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}

public extension FeedCache {
    func save(_ feed: [FeedImage]) throws {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        var result: FeedCache.Result!
        save(feed) {
            result = $0
            dispatchGroup.leave()
        }
        dispatchGroup.wait()
        try result.get()
    }
}
