//
//  FeedImageDataLoaderWithFallbackCompositeTests.swift
//  EssentialAppTests
//
//  Created by Petar Bel on 28.09.23.
//

import XCTest
import EssentialFeed

class FeedImageDataLoaderWithFallbackComposite: FeedImageDataLoader {
    private let primaryLoader: FeedImageDataLoader

    init(primary: FeedImageDataLoader, fallback: FeedImageDataLoader) {
        primaryLoader = primary
    }

    func loadImageData(from url: URL, completion: @escaping (FeedImageDataLoader.Result) -> Void) -> EssentialFeed.FeedImageDataLoaderTask {
        primaryLoader.loadImageData(from: url, completion: completion)
    }
}

final class FeedImageDataLoaderWithFallbackCompositeTests: XCTestCase {

    func test_load_deliversPrimaryDataOnPrimaryLoaderSuccess() {
        let primaryData = Data("Primary data".utf8)
        let fallbackData = Data("Fallback data".utf8)

        let sut = makeSUT(primaryResult: .success(primaryData), fallbackResult: .success(fallbackData))

        expect(sut, toCompleteWith: .success(primaryData))
    }

    // MARK: - Helpers

    private func makeSUT(primaryResult: FeedImageDataLoader.Result, fallbackResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) -> FeedImageDataLoader {
        let primaryLoader = FeedImageDataLoaderStub(result: primaryResult)
        let fallbackLoader = FeedImageDataLoaderStub(result: fallbackResult)

        let sut = FeedImageDataLoaderWithFallbackComposite(primary: primaryLoader, fallback: fallbackLoader)
        trackForMemoryLeaks(primaryLoader, file: file, line: line)
        trackForMemoryLeaks(fallbackLoader, file: file, line: line)
        trackForMemoryLeaks(sut, file: file, line: line)

        return sut
    }

    private func expect(_ sut: FeedImageDataLoader, toCompleteWith expectedResult: FeedImageDataLoader.Result, file: StaticString = #file, line: UInt = #line) {
        let exp = expectation(description: "Wait for load completion")

        let _ = sut.loadImageData(from: URL(string: "http://any-url.com")!) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedFeed), .success(expectedFeed)):
                XCTAssertEqual(receivedFeed, expectedFeed, file: file, line: line)
            case (.failure, .failure):
                break
            default:
                XCTFail("Expected \(expectedResult), got \(receivedResult) instead", file: file, line: line)
            }

            exp.fulfill()
        }

        wait(for: [exp], timeout: 1)
    }

    private class FeedImageDataLoaderStub: FeedImageDataLoader {
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

    private func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #file, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have been deallocated. Potential memory leak.", file: file, line: line)
        }
    }
}
