//
//  HudLoadingView.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import UIKit

class HudLoadingView: UIView {
  static let shared = HudLoadingView()
  
  private let activityIndicator: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.translatesAutoresizingMaskIntoConstraints = false
    indicator.hidesWhenStopped = true
    return indicator
  }()
  
  
  private let foregroundView: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = Colors.dialogContainerBG.withAlphaComponent(0.5)
    return view
  }()
  
  
  private let containerView: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = Colors.hudBackgroundView
    view.layer.cornerRadius = 10
    return view
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupView()
  }
  
  private func setupView() {
    addSubview(foregroundView)
    foregroundView.addInnerConstraint([.top, .leading, .trailing, .bottom], constant: 0)
    addSubview(containerView)
    containerView.addSubview(activityIndicator)
    containerView.addInnerConstraint([.width, .height], constant: 56)
    containerView.addInnerConstraint([.centerX, .centerY], constant: 0)
    activityIndicator.addInnerConstraint([.centerX, .centerY], constant: 0)
  }
  
  func show(in view: UIView) {
    if superview != nil { return }
    frame = view.bounds
    view.addSubview(self)
    activityIndicator.startAnimating()
  }
  
  func hide() {
    activityIndicator.stopAnimating()
    removeFromSuperview()
  }
}
