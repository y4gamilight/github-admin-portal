//
//  UserCardView.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import UIKit

struct UserCardViewConfig {
  let title: String
  let url: URL?
}

class UserCardView: UIView {
  
  enum Constant {
    static let regularPadding: CGFloat = 16.0
    static let smallPadding: CGFloat = 8.0
    static let avatarSize: CGFloat = 80.0
    static let xxSmallPadding: CGFloat = 4.0
  }
  
  static let identifierCell = "GithubUserCell"

  private var avatarContainer: UIView = {
    let view = UIView().forAutolayout()
    view.layer.cornerRadius = Constant.xxSmallPadding
    view.backgroundColor = .green
    return view
  }()
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    imageView.layer.cornerRadius = Constant.avatarSize / 2
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView().forAutolayout()
    stackView.axis = .vertical
    return stackView
  }()

  private lazy var usernameLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .black
    label.frame = .zero
    return label
  }()

  private lazy var lineView: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = .gray
    return view
  }()
  
  private let detailView: UIView?
  private var config: UserCardViewConfig? {
    didSet {
      usernameLabel.text = config?.title
    }
  }

  init(detailView: UIView? = nil) {
    self.detailView = detailView
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupView() {
    addSubview(avatarContainer)
    addSubview(stackView)
    avatarContainer.addSubview(avatarImageView)
    avatarContainer.addInnerConstraint([.width, .height], constant: Constant.avatarSize)
    avatarContainer.addInnerConstraint([.top, .leading, .bottom], constant: Constant.smallPadding)
    avatarImageView.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: 0)

    stackView.addArrangedSubview(usernameLabel)
    stackView.addArrangedSubview(lineView)
    if let detailView = detailView {
      stackView.addArrangedSubview(detailView)
    }
    lineView.addInnerConstraint(.height, constant: 1)
    stackView.addInnerConstraint(.trailing, constant: Constant.xxSmallPadding)
    stackView.relateTo(avatarContainer, relative: .alignTop, constant: Constant.xxSmallPadding)
    stackView.relateTo(avatarContainer, relative: .right, constant: Constant.xxSmallPadding)
  }

  func update(config: UserCardViewConfig) {
    self.config = config
  }
}


