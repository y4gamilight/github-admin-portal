//
//  BaseViewModel.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import Foundation

protocol BaseViewModel {
  associatedtype Input
  associatedtype Output
  associatedtype C: Coordinator
  var coordinator: C { get set }
  func transform(input: Input) -> Output
}

