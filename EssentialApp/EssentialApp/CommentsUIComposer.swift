//
//  CommentsUIComposer.swift
//  EssentialApp
//
//  Created by Petar Bel on 25.10.23.
//

import EssentialFeed
import EssentialFeediOS
import UIKit
import Combine

public final class CommentsUIComposer {
    private init() {}

    public static func commentsComposedWith(
        commentsLoader: @escaping () -> AnyPublisher<[FeedImage], Error>
    ) -> ListViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[FeedImage], FeedViewAdapter>(loader: commentsLoader)

        let feedViewController = ListViewController.makeWith(
            title: ImageCommentsPresenter.title)
        feedViewController.onRefresh = presentationAdapter.loadResource

        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: FeedViewAdapter(controller: feedViewController,
                                          imageLoader: { _ in Empty<Data, Error>().eraseToAnyPublisher()}),
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
        feedViewController.title = title
        return feedViewController
    }
}
