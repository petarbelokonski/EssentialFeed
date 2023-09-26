//
//  FeedImagesMapper.swift
//  EssentialFeed
//
//  Created by Petar Bel on 18.12.22.
//

import Foundation

final class FeedImagesMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem]  {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }

        return root.items
    }
}
