//
//  ImageCommentsMapper.swift
//  EssentialFeed
//
//  Created by Petar Bel on 14.10.23.
//

import Foundation

final class ImagesCommentsMapper {
    private struct Root: Decodable {
        let items: [RemoteFeedItem]
    }

    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [RemoteFeedItem]  {
        guard response.isOK, let root = try? JSONDecoder().decode(Root.self, from: data) else {
            throw RemoteImageCommentsLoader.Error.invalidData
        }

        return root.items
    }
}
