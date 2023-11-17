//
//  FeedImageDataCache.swift
//  EssentialFeed
//
//  Created by Petar Bel on 30.09.23.
//

import Foundation

public protocol FeedImageDataCache {
    func save(_ data: Data, for url: URL) throws
}
