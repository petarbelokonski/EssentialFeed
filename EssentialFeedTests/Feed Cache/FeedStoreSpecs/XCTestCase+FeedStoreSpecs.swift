//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Petar Bel on 21.08.23.
//

import XCTest
import EssentialFeed

extension FeedStoreSpecs where Self: XCTestCase {

     func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieve: .success(.none), file: file, line: line)
     }

     func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
     }

     func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let feed = uniqueImageFeed().local
         let timestamp = Date()

         insert((feed, timestamp), to: sut)

         expect(sut, toRetrieve: .success(CachedFeed(feed: feed, timestamp: timestamp)), file: file, line: line)
     }

     func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let feed = uniqueImageFeed().local
         let timestamp = Date()

         insert((feed, timestamp), to: sut)

         expect(sut, toRetrieveTwice: .success(CachedFeed(feed: feed, timestamp: timestamp)), file: file, line: line)
     }

     func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

         XCTAssertNil(insertionError, "Expected to insert cache successfully", file: file, line: line)
     }

     func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         insert((uniqueImageFeed().local, Date()), to: sut)

         let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

         XCTAssertNil(insertionError, "Expected to override cache successfully", file: file, line: line)
     }

     func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         insert((uniqueImageFeed().local, Date()), to: sut)

         let latestFeed = uniqueImageFeed().local
         let latestTimestamp = Date()
         insert((latestFeed, latestTimestamp), to: sut)

         expect(sut, toRetrieve: .success(CachedFeed(feed: latestFeed, timestamp: latestTimestamp)), file: file, line: line)
     }

     func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         let deletionError = deleteCache(from: sut)

         XCTAssertNil(deletionError, "Expected empty cache deletion to succeed", file: file, line: line)
     }

     func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         deleteCache(from: sut)

         expect(sut, toRetrieve: .success(.none), file: file, line: line)
     }

     func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         insert((uniqueImageFeed().local, Date()), to: sut)

         let deletionError = deleteCache(from: sut)

         XCTAssertNil(deletionError, "Expected non-empty cache deletion to succeed", file: file, line: line)
     }

     func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
         insert((uniqueImageFeed().local, Date()), to: sut)

         deleteCache(from: sut)

         expect(sut, toRetrieve: .success(.none), file: file, line: line)
     }

 }

extension FeedStoreSpecs where Self: XCTestCase {
    
    @discardableResult
    func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
        var insertionError: Error?
        do {
            try sut.insert(cache.feed, timestamp: cache.timestamp)
        } catch {
            insertionError = error
        }
        return insertionError
    }

    @discardableResult
    func deleteCache(from sut: FeedStore) -> Error? {
        var deletionError: Error?
        do {
            try sut.deleteCacheFeed()
        } catch {
            deletionError = error
        }
        return deletionError
    }

    func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: Result<CachedFeed?, Error>, file: StaticString = #file, line: UInt = #line) {
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
        expect(sut, toRetrieve: expectedResult, file: file, line: line)
    }

    func expect(_ sut: FeedStore, toRetrieve expectedResult: Result<CachedFeed?, Error>, file: StaticString = #file, line: UInt = #line) {
        let receivedResult = Result { try sut.retrieve() }
        switch (expectedResult, receivedResult) {
        case (.success(.none), .success(.none)),
            (.failure, .failure):
            break
        case let (.success(.some(expectedCache)), .success(.some(retrievedCache))):
            XCTAssertEqual(expectedCache.feed, retrievedCache.feed, file: file, line: line)
            XCTAssertEqual(expectedCache.timestamp, retrievedCache.timestamp, file: file, line: line)

        default:
            XCTFail("Expected to retrieve \(expectedResult), got \(receivedResult) instead", file: file, line: line)
        }
    }
}
