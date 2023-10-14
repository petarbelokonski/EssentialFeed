//
//  RemoteImageCommentsLoader.swift
//  EssentialFeed
//
//  Created by Petar Bel on 14.10.23.
//

import Foundation

public typealias RemoteImageCommentsLoader = RemoteLoader<[ImageComment]>

public extension RemoteImageCommentsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: ImagesCommentsMapper.map)
    }
}
