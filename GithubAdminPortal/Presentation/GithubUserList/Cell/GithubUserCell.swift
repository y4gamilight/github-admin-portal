//
//  GithubUserCell.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

typealias GithubUserCellItem = GithubUserCell.Model
final class GithubUserCell: UITableViewCell {
  struct Model {
    let uid: String
    let userName: String
    let profileURL: String
    let avatarURL: String?
    var imageData: Data?
    var onClickURL: ((String) -> ())?
    
    init(uid: String, userName: String = "", profileURL: String, avatarURL: String? = nil, onClickURL: ((String) -> Void)?) {
      self.uid = uid
      self.userName = userName
      self.profileURL = profileURL
      self.avatarURL = avatarURL
      self.onClickURL = onClickURL
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
    
    view.backgroundColor = .white
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.2
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 4
    view.layer.cornerRadius = Constant.regularPadding
    return view
  }()

  private lazy var hyperlinkLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.isUserInteractionEnabled = true
    label.textColor = .blue
    label.font = UIFont.systemFont(ofSize: 12)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hyperlinkTapped))
    label.addGestureRecognizer(tapGesture)
    return label
  }()

  @objc private func hyperlinkTapped() {
    guard let profileURL = model?.profileURL else { return }
    model?.onClickURL?(profileURL)
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
  }
  
  private (set) var model: GithubUserCellItem?
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    backgroundColor = .clear
    selectionStyle = .none
    contentView.addSubview(cardView)
    cardView.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: Constant.smallPadding)
    setNeedsLayout()
    layoutIfNeeded()
  }
  
  func configure(with model: Model) {
    self.model = model 
    cardView.update(config: UserCardViewConfig( title: model.userName, url: model.avatarURL))
    
    let attributedString = NSMutableAttributedString(string: model.profileURL)
    attributedString.addAttribute(.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: model.profileURL.count))
    hyperlinkLabel.attributedText = attributedString
  }
  
  func updateAvatarImage(_ image: UIImage?) {
    cardView.updateAvatar(image)
  }
  
}
