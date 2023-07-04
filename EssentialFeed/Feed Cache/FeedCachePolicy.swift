//
//  FeedCachePolicy.swift
//  EssentialFeed
//
//  Created by Petar Bel on 4.07.23.
//

import Foundation

internal final class FeedCachePolicy {
    private static let calendar = Calendar(identifier: .gregorian)

    private init() {}

    internal static func validate(_ timestamp: Date, against date: Date) -> Bool {
        let calendar = Calendar(identifier: .gregorian)
        guard let maxCacheAge = calendar.date(byAdding: .day, value: maxCacheAgeInDays, to: timestamp) else {
            return false
        }
        return date < maxCacheAge
    }

    private static var maxCacheAgeInDays: Int {
        7
    }
}
