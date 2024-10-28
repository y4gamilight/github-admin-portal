//
//  GithubUserDataSource.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

protocol GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserCellItem)
}

final class GithubUserDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
  var listener: GithubUserDataSourceListener?
  private var items: [GithubUserCellItem] = []
  
  var lazyLoadManager: LazyLoadUserAvatarManager
  init(lazyLoadManager: LazyLoadUserAvatarManager) {
    self.lazyLoadManager = lazyLoadManager
    super.init()
  }

  func registerCells(for tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(GithubUserCell.self, forCellReuseIdentifier: GithubUserCell.identifierCell)
  }

  func updateItems(_ items: [GithubUserCellItem]) {
    self.items = items
  }
  
  func stopLoadImages() {
    lazyLoadManager.reset()
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: GithubUserCell.identifierCell, for: indexPath) as! GithubUserCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    
    lazyLoadManager.asyncDown(item: item, index: indexPath.row) {[weak self] (data, index) in
      guard let this = self, let data = data else { return }
      this.items[indexPath.row].imageData = data
      DispatchQueue.main.async {
        guard let __cell = tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? GithubUserCell,
              let __cellItem = __cell.model, __cellItem.uid == item.uid else {
          return
        }
        __cell.updateAvatarImage(UIImage(data: data))
      }
    }
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
  
  func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row >= items.count { return }
    self.lazyLoadManager.slowDownImageDownloadTaskfor(items[indexPath.row])
  }
}
