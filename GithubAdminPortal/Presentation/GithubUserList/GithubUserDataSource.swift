//
//  GithubUserDataSource.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

protocol GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserItemCell)
}

final class GithubUserDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
  var listener: GithubUserDataSourceListener?
  private var items: [GithubUserItemCell] = []

  override init() {
    super.init()
  }

  func registerCells(for tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(GithubUserCell.self, forCellReuseIdentifier: GithubUserCell.identifierCell)
  }

  func updateItems(_ items: [GithubUserItemCell]) {
    self.items = items
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubUserCell.identifierCell, for: indexPath) as! GithubUserCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard indexPath.row < items.count else {
      assertionFailure("Indexpath out of range.")
      return
    }
    listener?.onSelectedGithubUserCell(items[indexPath.row])
  }
}
