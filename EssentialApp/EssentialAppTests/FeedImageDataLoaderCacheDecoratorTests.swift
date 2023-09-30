//
//  FeedImageDataLoaderCacheDecoratorTests.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 29.09.23.
//

import XCTest
import EssentialFeed
import EssentialApp

final class FeedImageDataLoaderCacheDecoratorTests: XCTestCase, FeedImageDataLoaderTestCase {

    func test_load_deliversOnLoaderSuccess() {
        let result: FeedImageDataLoader.Result = .success(anyData())
        let sut = makeSUT(result: result)

        expect(sut, toCompleteWith: result)
    }

    func test_load_deliversErrorOnLoaderFailure() {
        let result: FeedImageDataLoader.Result = .failure(anyNSError())
        let sut = makeSUT(result: result)

        expect(sut, toCompleteWith: result)
    }

    func test_cancelLoadImageData_cancelsLoaderTask() {
        let url = anyURL()
        let (sut, loader) = makeSpySUT()

        let task = sut.loadImageData(from: url) { _ in }
        task.cancel()

        XCTAssertEqual(loader.cancelledURLs, [url], "Expected to cancel URL loading from loader")
    }

    func test_loadImageData_cachesLoadedDataOnLoaderSuccess() {
        let cache = CacheSpy()
        let url = anyURL()
        let imageData = anyData()
        let (sut, loader) = makeSpySUT(cache: cache)

        _ = sut.loadImageData(from: url) { _ in }
        loader.complete(with: imageData)

        XCTAssertEqual(cache.messages, [.save(data: imageData, for: url)], "Expected to cache loaded image data on success")
    }

    // MARK - Helpers

    private class CacheSpy: FeedImageDataCache {
        private(set) var messages = [Message]()

        enum Message: Equatable {
            case save(data: Data, for: URL)
        }

        func save(_ data: Data, for url: URL, completion: @escaping (FeedImageDataCache.Result) -> Void) {
            messages.append(.save(data: data, for: url))
            completion(.success(()))
        }
    }

    private func makeSUT(result: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedImageDataLoader {
        let loader = FeedImageDataLoaderStub(result: result)
        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader, cache: CacheSpy())

        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }

    private func makeSpySUT(cache: CacheSpy = .init(), file: StaticString = #file, line: UInt = #line) -> (sut: FeedImageDataLoader, loader: FeedImageDataLoaderSpy) {        let loader = FeedImageDataLoaderSpy()
        let sut = FeedImageDataLoaderCacheDecorator(decoratee: loader, cache: cache)

        trackForMemoryLeaks(loader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)
        return (sut, loader)
    }
}
