//
//  PostCell.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell, Configurable {
  var viewModel: PostCellViewModel?

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.textColor = UIColor.gray
    label.font = UIFont(name: CustomTextStyle.body.name.rawValue, size: CustomTextStyle.body.size)

    return label
  }()

  private lazy var container: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.baseWhite
    view.layer.cornerRadius = 8
    view.layer.borderWidth = 1
    view.layer.borderColor = UIColor.baseDarkGray.cgColor
    view.addSubview(titleLabel)

    self.contentView.addSubview(view)

    return view
  }()

  override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupView()
    setupConstraints()
  }

  func setup(viewModel: RowViewModel) {
    guard let viewModel = viewModel as? PostCellViewModel else {
      return
    }

    self.viewModel = viewModel
    self.titleLabel.text = viewModel.title

    setNeedsLayout()
  }

  override func prepareForReuse() {
    super.prepareForReuse()
  }

  private func setupView() {
    self.selectionStyle = .none
    self.backgroundColor = UIColor.white
  }

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      container.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
      container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      container.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
      container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
    ])

    NSLayoutConstraint.activate([
      titleLabel.leftAnchor.constraint(equalTo: container.leftAnchor, constant: 10),
      titleLabel.topAnchor.constraint(equalTo: container.topAnchor, constant: 10),
      titleLabel.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -10),
      titleLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -10)
    ])

    titleLabel.accessibilityIdentifier = "titeLabel"
  }
}
