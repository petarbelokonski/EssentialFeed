//
//  FeedImageDataStore.swift
//  EssentialFeed
//
//  Created by Petar Bel on 27.09.23.
//

import Foundation

public protocol FeedImageDataStore {
    typealias Result = Swift.Result<Data?, Error>

    func retrieve(dataForURL url: URL, completion: @escaping (Result) -> Void)
}
