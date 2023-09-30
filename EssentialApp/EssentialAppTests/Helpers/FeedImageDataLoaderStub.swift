//
//  FeedImageDataLoaderStub.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 30.09.23.
//

import Foundation
import EssentialFeed

final class FeedImageDataLoaderStub: FeedImageDataLoader {
    private let result: FeedImageDataLoader.Result

    init(result: FeedImageDataLoader.Result) {
        self.result = result
    }

    private class Task: FeedImageDataLoaderTask {
        func cancel() {
        }
    }

    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeed.FeedImageDataLoaderTask {
        completion(result)
        return Task()
    }
}
