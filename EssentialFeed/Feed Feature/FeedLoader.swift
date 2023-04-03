//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Petar Bel on 14.12.22.
//

import Foundation

public enum LoadFeedResult {
    case success([FeedImage])
    case failure(Error)
}

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
