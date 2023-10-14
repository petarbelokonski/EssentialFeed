//
//  FeedUIComposer.swift
//  EssentialFeediOS
//
//  Created by Petar Bel on 9.09.23.
//

import EssentialFeed
import EssentialFeediOS
import UIKit
import Combine

public final class FeedUIComposer {
    private init() {}

    public static func feedComposedWith(
        feedLoader: @escaping () -> AnyPublisher<[FeedImage], Error>,
        imageLoader: @escaping (URL) -> FeedImageDataLoader.Publisher
    ) -> FeedViewController {
        let presentationAdapter = FeedLoaderPresentationAdapter(feedLoader: feedLoader)

        let feedViewController = FeedViewController.makeWith(
            delegate: presentationAdapter,
            title: FeedPresenter.title)

        presentationAdapter.presenter = FeedPresenter(
            feedView: FeedViewAdapter(controller: feedViewController,
                                      imageLoader: imageLoader),
            loadingView: WeakRefVirtualProxy(feedViewController),
            errorView: WeakRefVirtualProxy(feedViewController))

        return feedViewController
    }
}

private extension FeedViewController {
    static func makeWith(delegate: FeedViewControllerDelegate, title: String) -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedViewController = storyboard.instantiateInitialViewController() as! FeedViewController
        feedViewController.delegate = delegate
        feedViewController.title = FeedPresenter.title
        return feedViewController
    }
}
