//
//  WebViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//

import Foundation

protocol WebViewOutput {
  func loadWebPage()
}

class WebViewModel: BaseViewModel {
  var coordinator: Coordinator
  weak var input: WebViewInput?
  private var url: URL?
  init(coordinator: Coordinator, url: URL? = nil) {
    self.url = url
    self.coordinator = coordinator
  }
}

extension WebViewModel: WebViewOutput {
  func loadWebPage() {
    if let url = self.url {
      input?.loadRequest(URLRequest(url: url))
    }
  }
}
