//
//  FeedSnapshotTests.swift
//  EssentialFeediOSTests
//
//  Created by Petar Bel on 4.10.23.
//

import XCTest
@testable import EssentialFeediOS
@testable import EssentialFeed

final class FeedSnapshotTests: XCTestCase {

    func test_emptyFeed() {
        let sut = makeSUT()

        sut.display(emptyFeed())

        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "EMPTY_FEED_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "EMPTY_FEED_dark")
    }

    func test_feedWithContent() {
        let sut = makeSUT()

        sut.display(feedWithContent())

        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "FEED_WITH_CONTENT_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "FEED_WITH_CONTENT_dark")
    }

    func test_feedWithErrorMessage() {
        let sut = makeSUT()

        sut.display(.error(message: "This is a\nmultiline\nerror message."))

        assert(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "FEED_WITH_ERROR_MESSAGE_light")
        assert(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "FEED_WITH_ERROR_MESSAGE_dark")
    }

    func test_feedWithFailedImageLoading() {
        let sut = makeSUT()

        sut.display(feedWithFailedImageLoading())

        record(snapshot: sut.snapshot(for: .iPhone8(style: .light)), named: "FEED_WITH_FAILED_IMAGE_LOADING_light")
        record(snapshot: sut.snapshot(for: .iPhone8(style: .dark)), named: "FEED_WITH_FAILED_IMAGE_LOADING_dark")
    }

    // MARK: - Helpers

    private func makeSUT() -> FeedViewController {
        let bundle = Bundle(for: FeedViewController.self)
        let storyboard = UIStoryboard(name: "Feed", bundle: bundle)
        let controller = storyboard.instantiateInitialViewController() as! FeedViewController
        controller.loadViewIfNeeded()
        controller.tableView.showsVerticalScrollIndicator = false
        controller.tableView.showsHorizontalScrollIndicator = false

        return controller
    }

    private func emptyFeed() -> [FeedImageCellController] {
        return []
    }

    private func feedWithContent() -> [ImageStub] {
        return [
            ImageStub(
                description: "The East Side Gallery is an open-air gallery in Berlin.",
                location: "East Side Gallery\nMemorial in Berlin, Germany",
                image: UIImage.make(withColor: .red)
            ),
            ImageStub(
                description: "The West Side Gallery is an open-air gallery in London.",
                location: "West Side Gallery\nMemorial in London, Germany",
                image: UIImage.make(withColor: .green)
            )
        ]
    }

    private func feedWithFailedImageLoading() -> [ImageStub] {
        return [
            ImageStub(
                description: nil,
                location: "Cannon Street, London",
                image: nil
            ),
            ImageStub(
                description: nil,
                location: "Brighton Seafront",
                image: nil
            )
        ]
    }
}

private extension FeedViewController {
    func display(_ stubs: [ImageStub]) {
        let cells: [FeedImageCellController] = stubs.map { stub in
            let cellController = FeedImageCellController(viewModel: stub.viewModel, delegate: stub)
            stub.controller = cellController
            return cellController
        }

        display(cells)
    }
}

private class ImageStub: FeedImageCellControllerDelegate {
    let viewModel: FeedImageViewModel
    let image: UIImage?
    weak var controller: FeedImageCellController?

    init(description: String?, location: String?, image: UIImage?) {
        self.image = image
        viewModel = FeedImageViewModel(
            description: description,
            location: location)
    }

    func didRequestImage() {
        controller?.display(ResourceLoadingViewModel(isLoading: false))

        if let image = image {
            controller?.display(image)
            controller?.display(ResourceErrorViewModel(message: .none))
        } else {
            controller?.display(ResourceErrorViewModel(message: "any"))
        }
    }

    func didCancelImageRequest() {}
}
