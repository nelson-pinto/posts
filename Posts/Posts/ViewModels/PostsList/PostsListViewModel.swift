//
//  PostsListViewModel.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

class PostsListViewModel {
  let title = Observable<String>(value: "Loading")
  let isLoading = Observable<Bool>(value: false)
  let isTableViewHidden = Observable<Bool>(value: false)
  let sectionViewModels = Observable<[PostSectionViewModel]>(value: [])
}
