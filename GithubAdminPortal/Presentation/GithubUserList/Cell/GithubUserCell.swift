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
    static let regularPadding: CGFloat = 16.0
    static let smallPadding: CGFloat = 8.0
    static let avatarSize: CGFloat = 80.0
    static let xxSmallPadding: CGFloat = 4.0
  }
  
  static let identifierCell = "GithubUserCell"

  private lazy var cardView: UserCardView = {
    let view = UserCardView(detailView: hyperlinkLabel).forAutolayout()
    view.layer.cornerRadius = Constant.regularPadding
    view.backgroundColor = .white
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
  }
  
  func configure(with model: Model) {
    cardView.update(config: UserCardViewConfig( title: model.userName, url: model.imageView))
    
    let attributedString = NSMutableAttributedString(string: model.profileURL)
    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: model.profileURL.count))
    hyperlinkLabel.attributedText = attributedString
  }
  
}
