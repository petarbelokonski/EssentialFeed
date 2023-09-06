//
//  FeedLoader.swift
//  EssentialFeed
//
//  Created by Petar Bel on 14.12.22.
//

import Foundation

public typealias LoadFeedResult = Result<[FeedImage], Error>

public protocol FeedLoader {
    func load(completion: @escaping (LoadFeedResult) -> Void)
}
