//
//  CoreDataFeedStore.swift
//  EssentialFeed
//
//  Created by Petar Bel on 5.09.23.
//

import Foundation

public final class CoreDataFeedStore: FeedStore {
    public init() {}

    public func retrieve(completion: @escaping RetrievalCompletion) {
        completion(.empty)
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date, completion: @escaping InsertionCompletion) {

    }

    public func deleteCacheFeed(completion: @escaping DeletionCompletion) {

    }
}
