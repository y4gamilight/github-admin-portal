//
//  GithubUserListVC.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 24/10/24.
//

import UIKit

protocol GithubUserListInput: AnyObject {
  func updateUsers(_ items: [GithubUserCellItem])
  func appendUsers(_ items: [GithubUserCellItem])
  func stopLoadMore()
  func stopLazyLoads()
}

final class GithubUserListVC: BaseViewController<GithubUserListViewModel> {
  private lazy var usersTableView: UITableView = {
    let tableView = UITableView().forAutolayout()
    tableView.separatorStyle = .none
    tableView.backgroundColor = .clear
    return tableView
  }()
  
  private let dataSource = GithubUserDataSource(lazyLoadManager: LazyLoadUserAvatarManager())
  
  override func setup() {
    navigationItem.title = "Github Users"
    view.backgroundColor = .clear
    view.addSubview(usersTableView)
    usersTableView.addInnerConstraint([.top, .bottom, .leading, .trailing], constant: 0)
  }
  
  override func configuration() {
    dataSource.registerCells(for: usersTableView)
    dataSource.listener = viewModel
    
    viewModel.loadDataInLoadedView()
  }
}

extension GithubUserListVC: GithubUserListInput {
  func updateUsers(_ items: [GithubUserCellItem]) {
    dataSource.updateItems(items)
    usersTableView.reloadData()
  }
  
  func appendUsers(_ items: [GithubUserCellItem]) {
    dataSource.appendItems(items)
    usersTableView.reloadData()
  }
  
  func stopLoadMore() {
    dataSource.stopLoadMore(usersTableView)
  }
  
  func stopLazyLoads() {
    dataSource.stopLoadImages()
  }
}

