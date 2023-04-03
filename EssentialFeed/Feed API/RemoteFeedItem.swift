//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Petar Bel on 3.04.23.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
