//
//  GithubUserListViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

class GithubUserListViewModel: BaseViewModel {
  var coordinator: AppCoodinator
  
  init(coordinator: AppCoodinator) {
    self.coordinator = coordinator
  }
  
  func transform(input: Input) -> Output {
    return Output { items in
      
    } onAppendItems: { items in
      
    } onShowError: { error in
      
    }

  }
}

extension GithubUserListViewModel {
  struct Input {
    let getUsers: (() -> Void)
  }
  
  struct Output {
    let onUpdateItems: (([GithubUserItemCell]) -> Void)
    let onAppendItems: (([GithubUserItemCell]) -> Void)
    let onShowError: ((String) -> Void)
  }
}

extension GithubUserListViewModel: GithubUserDataSourceListener {
  func onSelectedGithubUserCell(_ item: GithubUserItemCell) {
    debugPrint("Selected value \(item.userName)")
  }
}
