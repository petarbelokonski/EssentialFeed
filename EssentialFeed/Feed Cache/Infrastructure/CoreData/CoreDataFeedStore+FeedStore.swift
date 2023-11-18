//
//  CoreDataFeedStore+FeedStore.swift
//  EssentialFeed
//
//  Created by Petar Bel on 27.09.23.
//

import CoreData

extension CoreDataFeedStore: FeedStore {

    public func retrieve() throws -> CachedFeed? {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map {
                    CachedFeed(feed: $0.localFeed, timestamp: $0.timestamp)
                }
            }
        }
    }

    public func insert(_ feed: [LocalFeedImage], timestamp: Date) throws {
        try performSync { context in
            Result {
                let managedCache = try ManagedCache.newUniqueInstance(in: context)
                managedCache.timestamp = timestamp
                managedCache.feed = ManagedFeedImage.images(from: feed, in: context)
                try context.save()
            }
        }
    }

    public func deleteCacheFeed() throws {
        try performSync { context in
            Result {
                try ManagedCache.find(in: context).map(context.delete).map(context.save)
            }
        }
    }
    
}
