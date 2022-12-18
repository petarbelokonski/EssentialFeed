//
//  FeedItem.swift
//  EssentialFeed
//
//  Created by Petar Bel on 14.12.22.
//

import Foundation

public struct FeedItem: Equatable {
    let id: UUID
    let description: String?
    let location: String?
    let imageURL: URL
}
