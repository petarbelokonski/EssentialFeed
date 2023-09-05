//
//  CoreDataFeedStoreTests.swift
//  EssentialFeedTests
//
//  Created by Petar Bel on 5.09.23.
//

import XCTest
import EssentialFeed

final class CoreDataFeedStoreTests: XCTestCase, FailableFeedStoreSpecs {

    func test_retrieve_deliversFailureOnRetrievalError() {
        let sut = makeSUT()

        assertThatRetrieveDeliversEmptyOnEmptyCache(on: sut)
    }

    func test_retrieve_hasNoSideEffectsOnFailure() {
        let sut = makeSUT()

        assertThatRetrieveHasNoSideEffectsOnEmptyCache(on: sut)
    }

    func test_insert_deliversErrorOnInsertionError() {

    }

    func test_insert_hasNoSideEffectsOnInsertionError() {

    }

    func test_delete_deliversErrorOnDeletionError() {

    }

    func test_delete_hasNoSideEffectsOnDeletionError() {

    }

    func test_retrieve_deliversEmptyOnEmptyCache() {

    }

    func test_retrieve_hasNoSideEffectsOnEmptyCache() {

    }

    func test_retrieve_deliversFoundValuesOnNonEmptyCache() {

    }

    func test_retrieve_hasNoSideEffectsOnNonEmptyCache() {

    }

    func test_insert_deliversNoErrorOnEmptyCache() {

    }

    func test_insert_deliversNoErrorOnNonEmptyCache() {

    }

    func test_insert_overridesPreviouslyInsertedCacheValues() {

    }

    func test_delete_deliversNoErrorOnEmptyCache() {

    }

    func test_delete_hasNoSideEffectsOnEmptyCache() {

    }

    func test_delete_deliversNoErrorOnNonEmptyCache() {

    }

    func test_delete_emptiesPreviouslyInsertedCache() {

    }

    func test_storeSideEffects_runSerially() {

    }

    // - MARK: Helpers

    private func makeSUT(file: StaticString = #file, line: UInt = #line) -> FeedStore {
        let storeBundle = Bundle(for: CoreDataFeedStore.self)
        let sut = try! CoreDataFeedStore(bundle: storeBundle)
        trackForMemoryLeaks(sut, file: file, line: line)
        return sut
    }
}
