//
//  RemoteFeedLoaderTests.swift
//  EssentialFeedTests
//
//  Created by Petar Bel on 16.12.22.
//

import XCTest
import EssentialFeed

class RemoteFeedLoaderTests: XCTestCase {

    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_load_requestsDataFromURLTwice() {
        let url = URL(string: "https://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)
        sut.load { _ in }
        sut.load { _ in }
        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        // Arrange
        let (sut, client) = makeSUT()

        // Act
        var capturedErrors = [RemoteFeedLoader.Error]()
        sut.load() { capturedErrors.append($0 ) }
        let clientError = NSError(domain: "TestError", code: 0)
        client.complete(with: clientError)

        // Assert
        XCTAssertEqual(capturedErrors, [.connectivity])
     }

    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples =  [199, 201, 300, 400, 500]
        samples.enumerated().forEach { index, code in
            var capturedErrors = [RemoteFeedLoader.Error]()
            sut.load() { capturedErrors.append($0 ) }

            client.complete(withStatusCode: code, at: index)
            XCTAssertEqual(capturedErrors, [.invalidData])
            capturedErrors = []
        }
    }
 
    // MARK: Helpers

    private func makeSUT(url: URL = URL(string: "https://a-url.com")!) -> (sut: RemoteFeedLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteFeedLoader(url: url, client: client)
        return (sut, client)
    }

    private class HTTPClientSpy: HTTPClient {
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }
        
        func complete(withStatusCode code: Int, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!
            messages[index].completion(.success(response))
        }
    }
}
