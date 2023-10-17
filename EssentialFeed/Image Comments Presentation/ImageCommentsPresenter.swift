//
//  ImageCommentsPresenter.swift
//  EssentialFeed
//
//  Created by Petar Bel on 17.10.23.
//

import Foundation

public final class ImageCommentsPresenter {
     public static var title: String {
        return NSLocalizedString(
            "IMAGE_COMMENTS_VIEW_TITLE",
            tableName: "ImageComments",
            bundle: Bundle(for: Self.self),
            comment: "Title for the image comments view")
    }

    public static func map(_ feed: [FeedImage]) -> FeedViewModel {
        FeedViewModel(feed: feed)
    }
}
