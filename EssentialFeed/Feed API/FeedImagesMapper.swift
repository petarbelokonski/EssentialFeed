//
//  FeedImagesMapper.swift
//  EssentialFeed
//
//  Created by Petar Bel on 18.12.22.
//

import Foundation

final class FeedImagesMapper {
    private struct Root: Decodable {
        private let items: [RemoteFeedItem]

        private struct RemoteFeedItem: Decodable {
            let id: UUID
            let description: String?
            let location: String?
            let image: URL
        }

        var images: [FeedImage] {
            items.map { FeedImage(id: $0.id, description: $0.description, location: $0.location, url: $0.image) }
        }
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [FeedImage]  {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteFeedLoader.Error.invalidData
        }

        return root.images
    }
}
