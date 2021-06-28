//
//  CustomTextStyle.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import Foundation
import UIKit

enum CustomTextStyle {
  case body
  case callout
  case caption1
  case caption2
  case footnote
  case headline
  case subheadline
  case title1(CustomFont)
  case title2(CustomFont)
  case custom(CustomFont, CGFloat)
  case largeTitle(CustomFont)

  var size: CGFloat {
    switch self {
    case .body:         return 16
    case .headline:     return 24
    case .subheadline:  return 24
    case .largeTitle:   return 34
    case .title1:       return 30
    case .title2:       return 24
    case .callout:      return 16
    case .caption1:     return 12
    case .caption2:     return 11
    case .footnote:     return 13
    case .custom(_, let size):  return size
    }
  }

  var name: CustomFont {
    switch self {
    case .body:                             return .medium
    case .headline:                         return .bold
    case .subheadline:                      return .ultralight
    case .caption1:                         return .medium
    case .caption2:                         return .medium
    case .callout:                          return .regular
    case .footnote:                         return .regular
    case .title1(let fontWeight):           return fontWeight
    case .title2(let fontWeight):           return fontWeight
    case .largeTitle(let fontWeight):       return fontWeight
    case .custom(let fontWeight, _):        return fontWeight
    }
  }
}
