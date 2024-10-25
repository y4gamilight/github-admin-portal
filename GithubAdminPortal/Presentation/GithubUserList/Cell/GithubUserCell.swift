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
    let userName: String
    let imageView: URL?
    
    init(userName: String = "", imageView: URL? = nil) {
      self.userName = userName
      self.imageView = imageView
    }
  }
  
  private lazy var avatarImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.forAutolayout()
    imageView.layer.cornerRadius = 20
    imageView.clipsToBounds = true
    return imageView
  }()
  
  private lazy var usernameLabel: UILabel = {
    let label = UILabel()
    label.forAutolayout()
    label.font = .systemFont(ofSize: 16, weight: .bold)
    label.textColor = .red
    label.backgroundColor = .white
    label.frame = .zero
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(usernameLabel)
    usernameLabel.addInnerConstraint([.top, .leading, .bottom, .trailing], constant: 0)
  }
  
  func configure(with model: Model) {
    avatarImageView.backgroundColor = UIColor.purple
    usernameLabel.text = model.userName
  }
  
}
