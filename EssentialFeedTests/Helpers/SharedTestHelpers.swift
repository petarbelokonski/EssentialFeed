//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Petar Bel on 3.07.23.
//

import Foundation

func anyNSError() -> NSError {
    return NSError(domain: "any error", code: 0)
}

func anyURL() -> URL {
    URL(string: "http://any-url.com")!
}
