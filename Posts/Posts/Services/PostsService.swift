//
//  PostsService.swift
//  Posts
//
//  Created by Nelson Pinto on 26/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation


enum PostServiceError: Error {
  case invalidResponse
  case noData
  case failedRequest
  case invalidData
}

struct PostsService {
  typealias PostServiceCompletion = ([PostResponse]?, PostServiceError?) -> ()

  private static let host = "jsonplaceholder.typicode.com"
  private static let path = "/posts"

  // Fetch posts
  static func fetchPosts(completion: @escaping PostServiceCompletion) {
    var urlBuilder = URLComponents()
    urlBuilder.scheme = "https"
    urlBuilder.host = host
    urlBuilder.path = path

    guard let url = urlBuilder.url else {
      NSLog("Failed to set url %s", urlBuilder.debugDescription)
      return
    }

    URLSession.shared.dataTask(with: url) { (data, response, error) in
      // Handle the response and call the completion
      DispatchQueue.main.async {
        guard error == nil else {
          NSLog("Failed request: %s", error?.localizedDescription ?? "")
          completion(nil, .failedRequest)
          return
        }

        guard let data = data else {
          NSLog("No data returned")
          completion(nil, .noData)
          return
        }

        guard let response = response as? HTTPURLResponse else {
          NSLog("Failed to process response")
          completion(nil, .invalidResponse)
          return
        }

        guard response.statusCode == 200 else {
          NSLog("Failure response: %d", response.statusCode)
          completion(nil, .failedRequest)
          return
        }

        do {
          let decoder = JSONDecoder()

          // Convert the posts from JSON representation to a list of PostResponse objects
          let posts: [PostResponse] = try decoder.decode([PostResponse].self, from: data)
          completion(posts, nil)
        } catch {
          NSLog("Unable to decode posts: %s", error.localizedDescription)
          completion(nil, .invalidData)
        }
      }
    }.resume()
  }
}
