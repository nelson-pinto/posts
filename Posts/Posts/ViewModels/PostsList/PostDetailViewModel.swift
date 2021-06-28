//
//  PostDetailViewModel.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

class PostDetailViewModel {
  let title = Observable<String>(value: "")
  let body = Observable<String>(value: "")
}
