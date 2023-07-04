//
//  FeedCacheTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Petar Bel on 3.07.23.
//

import Foundation
import EssentialFeed

func uniqueImageFeed() -> (models: [FeedImage], local: [LocalFeedImage]) {
    let images = [uniqueImage(), uniqueImage()]
    let localImages = images.map { LocalFeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.url) }
    return (images, localImages)
}

func uniqueImage() -> FeedImage {
    FeedImage(id: UUID(), description: "any", location: "any", url: anyURL())
}

extension Date {
    func minusFeedCacheMaxAge() -> Date {
        return adding(days: -7)
    }

    func adding(days: Int) -> Date {
        return Calendar(identifier: .gregorian).date(byAdding: .day, value: days, to: self)!
    }

    func adding(seconds: TimeInterval) -> Date {
        return self + seconds
    }
}
