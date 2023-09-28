//
//  FeedLoaderWithFallbackComposite.swift
//  EssentialApp
//
//  Created by Petar Bel on 28.09.23.
//

import Foundation
import EssentialFeed

public class FeedLoaderWithFallbackComposite: FeedLoader {
    private let primaryLoader: FeedLoader
    private let fallbackLoader: FeedLoader

    public init(primary: FeedLoader, fallback: FeedLoader) {
        primaryLoader = primary
        fallbackLoader = fallback
    }

    public func load(completion: @escaping (FeedLoader.Result) -> Void) {
        primaryLoader.load { [weak self] result in
            switch result {
            case .success:
                completion(result)
            case .failure:
                self?.fallbackLoader.load(completion: completion)
            }
        }
    }
}
