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
        commentsLoader: @escaping () -> AnyPublisher<[ImageComment], Error>
    ) -> ListViewController {
        let presentationAdapter = LoadResourcePresentationAdapter<[ImageComment], CommentsViewAdapter>(loader: commentsLoader)

        let commentsViewController = ListViewController.makeCommentsViewController(
            title: ImageCommentsPresenter.title)
        commentsViewController.onRefresh = presentationAdapter.loadResource

        presentationAdapter.presenter = LoadResourcePresenter(
            resourceView: CommentsViewAdapter(controller: commentsViewController),
            loadingView: WeakRefVirtualProxy(commentsViewController),
            errorView: WeakRefVirtualProxy(commentsViewController),
            mapper: { ImageCommentsPresenter.map($0) })

        return commentsViewController
    }
}

final class CommentsViewAdapter: ResourceView {
    private weak var controller: ListViewController?

    init(controller: ListViewController) {
        self.controller = controller
    }

    func display(_ viewModel: ImageCommentsViewModel) {
        controller?.display(viewModel.comments.map { viewModel in
            CellController(id: viewModel, ImageCommentCellController(model: viewModel))
        })
    }
}

private extension ListViewController {
    static func makeCommentsViewController(title: String) -> ListViewController {
        let bundle = Bundle(for: ListViewController.self)
        let storyboard = UIStoryboard(name: "ImageComments", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! ListViewController
        controller.title = title
        return controller
    }
}
