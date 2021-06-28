//
//  Extensions.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import UIKit

public extension UITableViewCell {
  // Cell identifier derived from class name
  public static func cellIdentifier() -> String {
    return String(describing: self)
  }
}

extension NSLayoutConstraint {
  // Layout constraint with priority
  func withPriority(priority: UILayoutPriority) -> NSLayoutConstraint {
    self.priority = priority
    return self
  }
}

public extension UIView {
  // Constraints to superview's edge
  public func edgeConstraints(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> [NSLayoutConstraint] {
    if let superview = self.superview {
      return [
        self.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: left),
        self.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -right),
        self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top),
        self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom)
      ]
    } else {
      return []
    }
  }
}
