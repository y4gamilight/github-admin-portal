//
//  WebVC.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//

import Foundation
import UIKit
import WebKit

protocol WebViewInput: AnyObject {
  func loadRequest(_ urlRequest: URLRequest)
}

final class WebVC: BaseViewController<WebViewModel> {
  private lazy var webView: WKWebView = {
    let webConfiguration = WKWebViewConfiguration()
    let webView = WKWebView(frame: containerView.bounds, configuration: webConfiguration)
    webView.sizeToFit()
    webView.navigationDelegate = self
    return webView
  }()
  
  private lazy var containerView: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = Colors.primaryBg
    return view
  }()
  
  private lazy var closeImageView: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    imageView.image = Images.image(.icClose)
    return imageView
  }()
  
  private lazy var closeButton: UIButton = {
    let button = UIButton().forAutolayout()
    button.addTarget(self, action: #selector(closeClicked), for: .touchUpInside)
    return button
  }()
  
  override func setup() {
    view.addSubview(containerView)
    containerView.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: 0)
    containerView.addSubview(closeButton)
    closeButton.addSubview(closeImageView)
    closeButton.addInnerConstraint([.top, .leading], constant: 0)
    closeButton.addInnerConstraint([.width, .height], constant: 48)
    closeImageView.addInnerConstraint([.width, .height], constant: 24)
    closeImageView.addInnerConstraint([.centerX, .centerY], constant: 0)
    
    containerView.addSubview(webView)
    webView.addInnerConstraint([.bottom, .leading, .trailing], constant: 0)
    webView.relateTo(closeButton, relative: .down, constant: 0)
  }
  
  override func configuration() {
    viewModel.loadWebPage()
  }
  
  @objc func closeClicked() {
    self.dismiss(animated: true)
  }
}

extension WebVC: WebViewInput {
  func loadRequest(_ urlRequest: URLRequest) {
    webView.load(urlRequest)
  }
}

extension WebVC: WKNavigationDelegate, WKUIDelegate {
  func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    
  }
}
