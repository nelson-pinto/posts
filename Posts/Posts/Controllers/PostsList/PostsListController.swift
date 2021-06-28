//
//  PostsListController.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

class PostsListController {
  let viewModel: PostsListViewModel

  init(viewModel: PostsListViewModel = PostsListViewModel()) {
    self.viewModel = viewModel
  }

  func start() {
    // Setting the view model properties, triggers changes in the View Controller that owns this controller
    self.viewModel.isLoading.value = true
    self.viewModel.isTableViewHidden.value = true
    self.viewModel.title.value = "Loading..."

    // Fetch all the posts. The post are accessible in the completion block as list of PostResponse objects
    PostsService.fetchPosts { [weak self] (posts, _) in
      // TODO - use the error in (posts, error) in the future (for now it's ignored)
      defer {
        self?.viewModel.isLoading.value = false
        self?.viewModel.isTableViewHidden.value = false
        self?.viewModel.title.value = "Posts"
      }

      if let posts = posts {
        let manager = CoreDataManager.shared

        for postResponse in posts {
          let currentPost = Post(context: manager.context)
          currentPost.id = postResponse.id
          currentPost.userId = postResponse.userId
          currentPost.title = postResponse.title
          currentPost.body = postResponse.body

          manager.save()
        }

        // Build the view models used by the View Controller
        self?.buildPostCellViewModels(posts: posts)
      }
    }
  }

  // MARK: - Data source

  // Build the view models and categorize by userId
  func buildPostCellViewModels(posts: [PostResponse]) {
    // Content of the TableView sections.
    var tableSections = [Int64: [RowViewModel]]()

    for post in posts {
      let postCellViewModel = PostCellViewModel(id: post.id, title: post.title)

      // Add the row (PostCellViewModel) to the appropriate section
      if var rows = tableSections[post.userId] {
        rows.append(postCellViewModel)
        tableSections[post.userId] = rows
      } else {
        tableSections[post.userId] = [postCellViewModel]
      }
    }

    // Trigger the changes in order to update the UI
    self.viewModel.sectionViewModels.value = convertToPostSectionViewModel(tableSections)
  }

  func cellIdentifier() -> String {
    return PostCell.cellIdentifier()
  }

  // Convert the date-hashed row viewmodels into array-based section viewmodels
  private func convertToPostSectionViewModel(_ tableSections: [Int64: [RowViewModel]]) -> [PostSectionViewModel] {
    // Sort the array based on the user id
    let sortedTableSections = tableSections.keys.sorted(by: <)

    return sortedTableSections.map {
      if let rowViewModels = tableSections[$0] {
        return PostSectionViewModel(headerTitle: "User ID " + String($0), rowViewModels: rowViewModels)
      } else {
        return PostSectionViewModel(headerTitle: "User ID " + String($0), rowViewModels: [])
      }
    }
  }
}
