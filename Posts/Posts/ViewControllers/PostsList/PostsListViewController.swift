//
//  PostsListViewController.swift
//  Posts
//
//  Created by Nelson Pinto on 26/06/2021.
//  Copyright © 2021 Nelson Pinto. All rights reserved.
//

import UIKit

class PostsListViewController: UIViewController {
  var viewModel: PostsListViewModel {
    return controller.viewModel
  }

  // Controller associated with this View Controller
  lazy var controller: PostsListController = {
    return PostsListController()
  }()

  // MARK: - UI components

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.delegate = self
    tableView.dataSource = self
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.estimatedRowHeight = 80
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.register(PostCell.self, forCellReuseIdentifier: PostCell.cellIdentifier())
    tableView.separatorColor = UIColor.clear

    self.view.addSubview(tableView)

    NSLayoutConstraint.activate(tableView.edgeConstraints(top: 0, left: 0, bottom: 0, right: 0))

    return tableView
  }()

  lazy var loadingIdicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true

    self.view.addSubview(indicator)

    NSLayoutConstraint.activate([
      indicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
      indicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    ])

    return indicator
  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    setupView()
    initBinding()
    controller.start()
  }

  func setupView() {
    self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.baseDarkGray]
    view.backgroundColor = .white
  }

  func initBinding() {
    viewModel.sectionViewModels.bind(fireNow: false) { [weak self] (_) in
      self?.tableView.reloadData()
    }

    viewModel.title.bind { [weak self] (title) in
      //self?.titleLabel.text = title
      self?.navigationItem.title = title
    }

    viewModel.isTableViewHidden.bind { [weak self] (isHidden) in
      self?.tableView.isHidden = isHidden
    }

    viewModel.isLoading.bind { [weak self] (isLoading) in
      if isLoading {
        self?.loadingIdicator.startAnimating()
      } else {
        self?.loadingIdicator.stopAnimating()
      }
    }
  }
}

// MARK: - table view delegates and datasource methods

extension PostsListViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return viewModel.sectionViewModels.value.count
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.sectionViewModels.value[section].rowViewModels.count
  }

  func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
    return true
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let rowViewModel = viewModel.sectionViewModels.value[indexPath.section].rowViewModels[indexPath.row]
    let cell = tableView.dequeueReusableCell(withIdentifier: controller.cellIdentifier(), for: indexPath)

    if let cell = cell as? Configurable {
      cell.setup(viewModel: rowViewModel)
    }

    cell.layoutIfNeeded()

    return cell
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    if let rowViewModel = viewModel.sectionViewModels.value[indexPath.section].rowViewModels[indexPath.row] as? PostCellViewModel {
      let postDetailController = PostDetailController()
      postDetailController.id = rowViewModel.id
      let postDetailViewController = PostDetailViewController()
      postDetailViewController.controller = postDetailController

      self.navigationController?.pushViewController(postDetailViewController, animated: true)
    }
  }

  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let view = PostSectionHeaderView()
    view.setTitle(viewModel.sectionViewModels.value[section].headerTitle)

    return view
  }
}
