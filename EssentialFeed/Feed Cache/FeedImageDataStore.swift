//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Petar Bel on 27.09.23.
//

import Foundation

public protocol FeedImageDataStore {
    func insert(_ data: Data, for url: URL) throws
    func retrieve(dataForURL url: URL) throws -> Data?
}
