//
//  GithubUserCell.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

typealias GithubUserItemCell = GithubUserCell.Model
final class GithubUserCell: UITableViewCell {
  struct Model {
    let uid: String
    let userName: String
    let profileURL: String
    let imageView: URL?
    
    init(uid: String, userName: String = "", profileURL: String, imageView: URL? = nil) {
      self.uid = uid
      self.userName = userName
      self.profileURL = profileURL
      self.imageView = imageView
    }
  }

  enum Constant {
    static let regularPadding = 16.0
    static let smallPadding = 8.0
    static let avatarSize = 80.0
    static let xxSmallPadding = 4.0
  }
  
  static let identifierCell = String(describing: self)

  private lazy var cardView: UIView = {
    let view = UIView().forAutolayout()
    view.layer.cornerRadius = Constant.regularPadding
    view.backgroundColor = .white
    return view
  }()

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

  private lazy var hyperlinkLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.isUserInteractionEnabled = true
    label.textColor = .blue
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hyperlinkTapped))
    label.addGestureRecognizer(tapGesture)
    return label
  }()

  @objc private func hyperlinkTapped() {
    // Handle hyperlink tap action
    debugPrint("Hyperlink tapped")
  }

  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    selectionStyle = .none
    contentView.addSubview(cardView)
    cardView.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: Constant.smallPadding)
    
    cardView.addSubview(avatarContainer)
    cardView.addSubview(stackView)
    avatarContainer.addSubview(avatarImageView)
    avatarContainer.addInnerConstraint([.width, .height], constant: Constant.avatarSize)
    avatarContainer.addInnerConstraint([.top, .leading, .bottom], constant: Constant.smallPadding)
    avatarImageView.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: 0)

    stackView.addArrangedSubview(usernameLabel)
    stackView.addArrangedSubview(lineView)
    stackView.addArrangedSubview(hyperlinkLabel)
    lineView.addInnerConstraint(.height, constant: 1)
    stackView.addInnerConstraint(.trailing, constant: Constant.xxSmallPadding)
    stackView.relateTo(avatarContainer, relative: .alignTop, constant: Constant.xxSmallPadding)
    stackView.relateTo(avatarContainer, relative: .right, constant: Constant.xxSmallPadding)
  }
  
  func configure(with model: Model) {
    usernameLabel.text = model.userName
    
    let attributedString = NSMutableAttributedString(string: model.profileURL)
    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: model.profileURL.count))
    hyperlinkLabel.attributedText = attributedString
  }
  
}
