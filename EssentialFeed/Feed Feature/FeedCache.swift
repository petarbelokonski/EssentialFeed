//
//  FeedCache.swift
//  EssentialFeed
//
//  Created by Petar Bel on 29.09.23.
//

import Foundation

public protocol FeedCache {
    typealias Result = Swift.Result<Void, Error>

    func save(_ feed: [FeedImage], completion: @escaping (Result) -> Void)
}
