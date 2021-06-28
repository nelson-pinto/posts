//
//  PostSectionHeaderView.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import UIKit

public class PostSectionHeaderView: UIView {
  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    self.addSubview(label)

    label.font = UIFont(name: CustomFont.bold.rawValue, size: CustomTextStyle.body.size)
    label.textColor = UIColor.baseDarkGray
    return label
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
    setupConstraints()
  }

  public required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
    setupConstraints()
  }

  public func setTitle(_ text: String) {
    self.titleLabel.text = text
  }

  private func setupView() {
    self.backgroundColor = UIColor.white
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate(titleLabel.edgeConstraints(top: 5, left: 10, bottom: 5, right: 10))
  }
}
