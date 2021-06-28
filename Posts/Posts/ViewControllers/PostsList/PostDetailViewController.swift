//
//  PostDetailViewController.swift
//  Posts
//
//  Created by Nelson Pinto on 27/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import UIKit

class PostDetailViewController: UIViewController {
  let scrollView = UIScrollView()
  let contentView = UIView()

  var viewModel: PostDetailViewModel {
    return controller.viewModel
  }

  lazy var controller: PostDetailController = {
    return PostDetailController()
  }()

  // MARK: - UI components

  private lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: CustomFont.bold.rawValue, size: CustomTextStyle.body.size)
    label.numberOfLines = 0
    label.textColor = UIColor.baseDarkGray

    return label
  }()

  private lazy var bodyLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont(name: CustomTextStyle.body.name.rawValue, size: CustomTextStyle.body.size)
    label.numberOfLines = 0
    label.textColor = UIColor.baseDarkGray

    return label
  }()

  private lazy var separator: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = UIColor.baseGray

    return view
  }()

  // MARK: - view setup

  override func viewDidLoad() {
    super.viewDidLoad()

    setupScrollView()
    setupViews()
    setupView()
    initBinding()
    controller.start()
  }

  func setupScrollView() {
    scrollView.translatesAutoresizingMaskIntoConstraints = false
    contentView.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(scrollView)
    scrollView.addSubview(contentView)
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

    contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
  }

  func setupViews() {
    self.navigationController?.navigationBar.tintColor = UIColor.baseDarkGray

    contentView.addSubview(titleLabel)
    titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
    titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true

    contentView.addSubview(separator)
    separator.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    separator.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
    separator.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    separator.heightAnchor.constraint(equalToConstant: 1).isActive = true

    contentView.addSubview(bodyLabel)
    bodyLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true
    bodyLabel.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: 10).isActive = true
    bodyLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10).isActive = true
    bodyLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
  }

  func setupView() {
    view.backgroundColor = .white
  }

  func initBinding() {
    viewModel.title.bind { [weak self] (title) in
      self?.titleLabel.text = title
    }
    viewModel.body.bind { [weak self] (body) in
      self?.bodyLabel.text = body
    }
  }

}
