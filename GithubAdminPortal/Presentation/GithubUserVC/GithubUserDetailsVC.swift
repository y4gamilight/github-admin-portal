//
//  GithubUserDetailsVC.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

protocol GithubUserDetailsInput: AnyObject {
  func updateUserDetails(user: GithubUserDetails)
}

final class GithubUserDetailsVC: BaseViewController<GithubUserDetailsViewModel> {

}

extension GithubUserDetailsVC: GithubUserDetailsInput {
  func updateUserDetails(user: GithubUserDetails) {
    
  }
}
