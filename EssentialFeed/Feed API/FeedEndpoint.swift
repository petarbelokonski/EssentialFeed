//
//  FeedEndpoint.swift
//  EssentialFeed
//
//  Created by Petar Bel on 26.10.23.
//

import Foundation

public enum FeedEndpoint {
    case get
    
    public func url(baseURL: URL) -> URL {
        switch self {
        case .get:
            return baseURL.appendingPathComponent("/v1/feed")
        }
    }
}
