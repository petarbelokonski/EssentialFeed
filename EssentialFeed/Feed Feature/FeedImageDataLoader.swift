//
//  FeedImageDataLoader.swift
//  EssentialFeediOS
//
//  Created by Petar Bel on 9.09.23.
//

import Foundation

public protocol FeedImageDataLoader {
    func loadImageData(from url: URL) throws -> Data
}
