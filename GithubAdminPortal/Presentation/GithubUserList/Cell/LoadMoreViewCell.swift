//
//  LoadMoreViewCell.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

class LoadMoreViewCell: UITableViewCell {
    
  static let identifierCell = "LoadMoreViewCell" 
  enum Constant {
    static let mediumPadding: CGFloat = 24.0
    static let smallPadding: CGFloat = 8.0
  }
  private lazy var loadingLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = "Loading more..."
    label.textColor = Colors.primaryContent
    label.textAlignment = .center
    return label
  }()
  
  private lazy var activityIndicator: UIActivityIndicatorView = {
    let activityIndicator = UIActivityIndicatorView().forAutolayout()
    activityIndicator.color = Colors.primaryContent
    return activityIndicator
  }()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    selectionStyle = .none
    backgroundColor = Colors.primaryBg
    addSubview(loadingLabel)
    addSubview(activityIndicator)
    
    loadingLabel.addInnerConstraint([.top, .leading, .trailing], constant: Constant.mediumPadding)
    activityIndicator.addInnerConstraint(.centerX, constant: 0)
    activityIndicator.relateTo(loadingLabel, relative: .down, constant: Constant.mediumPadding)
    activityIndicator.addInnerConstraint([.bottom], constant: Constant.mediumPadding)
  }
  
  func startAnimation() {
    activityIndicator.startAnimating()
  }
}
