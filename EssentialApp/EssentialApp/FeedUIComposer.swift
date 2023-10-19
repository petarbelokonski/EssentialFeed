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
    ) -> ListViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: feedLoader)

        let feedViewController = ListViewController.makeWith(
            title: FeedPresenter.title)
        feedViewController.onRefresh = presentationAdapter.loadResource

        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(controller: feedViewController,
                                          imageLoader: imageLoader),
            loadingView: WeakRefVirtualProxy(feedViewController),
            errorView: WeakRefVirtualProxy(feedViewController),
            mapper: FeedPresenter.map)

        return feedViewController
    }
}

private extension ListViewController {
    static func makeWith(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let feedViewController = storyboard.instantiateInitialViewController() as! ListViewController
        feedViewController.title = FeedPresenter.title
        return feedViewController
    }
}
