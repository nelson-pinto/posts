//
//  Observable.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation

// Class used to bind a callback to a UI component
class Observable<T> {
  private var onChange: ((T) -> Void)?

  var value: T {
    didSet {
      DispatchQueue.main.async {
        self.onChange?(self.value)
      }
    }
  }

  init(value: T) {
    self.value = value
  }

  public func bind(fireNow: Bool = true, _ onChange: ((T) -> Void)?) {
    self.onChange = onChange
    if fireNow {
      self.onChange?(value)
    }
  }

  public func unbind() {
    self.onChange = nil
  }
}
