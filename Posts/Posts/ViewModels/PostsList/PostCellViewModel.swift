//
//  PostCellViewModel.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

class PostCellViewModel: RowViewModel {
  let id: Int64
  let title: String

  init(id: Int64, title: String) {
    self.id = id
    self.title = title
  }
}
