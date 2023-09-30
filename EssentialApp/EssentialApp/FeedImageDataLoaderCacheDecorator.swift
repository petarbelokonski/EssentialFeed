//
//  FeedImageDataLoaderCacheDecorator.swift
//  EssentialApp
//
//  Created by Petar Bel on 30.09.23.
//

import Foundation
import EssentialFeed

public final class FeedImageDataLoaderCacheDecorator: FeedImageDataLoader {
    private let decoratee: FeedImageDataLoader

    public init(decoratee: FeedImageDataLoader) {
        self.decoratee = decoratee
    }

    public func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeed.FeedImageDataLoaderTask {
        decoratee.loadImageData(from: url, completion: completion)
    }
}
