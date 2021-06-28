//
//  PostResponse.swift
//  Posts
//
//  Created by Nelson Pinto on 26/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

// Convert a post from a JSON representation
struct PostResponse: Decodable {
  var id: Int64 = 0
  var userId: Int64 = 0
  var title = ""
  var body = ""

  enum CodingKeys: String, CodingKey {
    case id, userId, title, body
  }

  init(from decoder: Decoder) throws {
    let values = try decoder.container(keyedBy: CodingKeys.self)

    id = try values.decode(Int64.self, forKey: .id)
    userId = try values.decode(Int64.self, forKey: .userId)
    title = try values.decode(String.self, forKey: .title)
    body = try values.decode(String.self, forKey: .body)
  }
}
