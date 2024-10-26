//
//  GithubUserListVC.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

class GithubUserListVC: BaseViewController<GithubUserListViewModel> {
  private lazy var usersTableView: UITableView = {
    let tableView = UITableView()
    tableView.forAutolayout()
    return tableView
  }()
  
  private let dataSource = GithubUserDataSource()
  
  override func setup() {
    navigationItem.title = "Github Users"
    view.backgroundColor = .blue
    view.addSubview(usersTableView)
    NSLayoutConstraint.activate([
      NSLayoutConstraint(item: usersTableView, attribute: .topMargin, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: usersTableView, attribute: .bottomMargin, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: usersTableView, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0),
      NSLayoutConstraint(item: usersTableView, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0),
    ])
  }
  
  override func configuration() {
    dataSource.registerCells(for: usersTableView)
    dataSource.listener = viewModel
    usersTableView.reloadData()
  }
}

