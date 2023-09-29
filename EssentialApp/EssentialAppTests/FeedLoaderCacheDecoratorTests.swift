//
//  FeedLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 29.09.23.
//

import XCTest
import EssentialFeed

final class FeedLoaderCacheDecorator: FeedLoader {
    private let decoratee: FeedLoader

    init(decoratee: FeedLoader) {
        self.decoratee = decoratee
    }

    func load(completion: @escaping (FeedLoader.Result) -> Void) {
        decoratee.load(completion: completion)
    }
}

final class FeedLoaderCacheDecoratorTests: XCTestCase, FeedLoaderTestCase {

    func test_load_deliversOnLoadedSuccess() {
        let feed = uniqueFeed()
        let loader = FeedLoaderStub(result: .success(feed))

        let sut = FeedLoaderCacheDecorator(decoratee: loader)

        expect(sut, toCompleteWith: .success(feed))
    }

    func test_load_deliversErrorOnLoaderFailure() {
        let error = anyNSError()
        let loader = FeedLoaderStub(result: .failure(error))

        let sut = FeedLoaderCacheDecorator(decoratee: loader)

        expect(sut, toCompleteWith: .failure(error))
    }
}
