//
//  GithubUserDataSource.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

final class GithubUserDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
  
  private var items: [GithubUserItemCell]

  override init() {
    items = (1...20).map { i in
      GithubUserItemCell(userName: "user\(i)", imageView: URL(string: "https://example.com/avatar\(i).png"))
    }
    super.init()
  }

  func registerCells(for tableView: UITableView) {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(GithubUserCell.self, forCellReuseIdentifier: "GithubUserCell")
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GithubUserCell", for: indexPath) as! GithubUserCell
    let item = items[indexPath.row]
    cell.configure(with: item)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
