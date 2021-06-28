//
//  PostDetailController.swift
//  Posts
//
//  Created by Nelson Pinto on 28/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation
import CoreData

class PostDetailController {
  // The post id (used to fetch it from the database)
  var id: Int64 = 0
  // View Model used by the PostDetailViewController
  let viewModel: PostDetailViewModel

  init(viewModel: PostDetailViewModel = PostDetailViewModel()) {
    self.viewModel = viewModel
  }

  // Public method called by the PostDetailViewController whenever it finished loading
  public func start() {
    // Fetch the post from the database and trigger the changes in the View Controller
    if let post = fetchPost(with: id) {
      if let title = post.title {
        self.viewModel.title.value = title
      }
      if let body = post.body {
        self.viewModel.body.value = body
      }
    }
  }

  // Fetch a post by id from the database
  private func fetchPost(with id: Int64) -> Post? {
    var post: Post?

    let request = NSFetchRequest<Post>(entityName: "Post")
    request.predicate = NSPredicate(format: "id == %i", id)
    request.fetchLimit = 1

    post = try? CoreDataManager.shared.context.fetch(request).first!

    return post
  }
}
