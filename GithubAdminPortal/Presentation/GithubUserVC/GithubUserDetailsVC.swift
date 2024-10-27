//
//  GithubUserDetailsVC.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//
import UIKit

protocol GithubUserDetailsInput: AnyObject {
  func updateUserDetails(user: GithubUserDetails)
}

final class GithubUserDetailsVC: BaseViewController<GithubUserDetailsViewModel> {
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView().forAutolayout()
    stackView.axis = .vertical
    stackView.alignment = .center
    return stackView
  }()

  private lazy var userCardView: UserCardView = {
    let view = UserCardView(detailView: locationContainer).forAutolayout()
    view.layer.cornerRadius = 16
    view.backgroundColor = .white
    return view
  }()

  private lazy var locationContainer: UIView = {
    let view = UIView().forAutolayout()
    return view
  }()

  private lazy var locationLogo: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    return imageView
  }()

  private lazy var locationLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()

  private lazy var userStatsContainer: UIStackView = {
    let view = UIStackView().forAutolayout()
    view.axis = .horizontal
    view.distribution = .fillEqually
    view.alignment = .center
    
    return view
  }()

  private lazy var followerStatView: StatView = {
    let view = StatView(config: .init(stat: "0", unit: "follower", iconName: "")).forAutolayout()
    return view
  }()

  private lazy var followingStatView: StatView = {
    let view = StatView(config: .init(stat: "0", unit: "following", iconName: "")).forAutolayout()
    return view
  }()

  private lazy var userBioContainer: UIView = {
    let view = UIView().forAutolayout()
    return view
  }()
  
  private lazy var bioHeader: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = "Blog"
    return label
  }()
  
  private lazy var bioTextView: UITextView = {
    let textView = UITextView().forAutolayout()
    textView.isEditable = false
    return textView
  }()

  override func setup() { 
    navigationItem.title = "User Details" 
    view.addSubview(stackView)
    stackView.addInnerConstraint([.top, .leading, .trailing, .bottom], constant: 0)

    locationContainer.addSubview(locationLogo)
    locationContainer.addSubview(locationLabel)
    locationLogo.addInnerConstraint([.leading], constant: 0)
    locationLogo.addInnerConstraint([.width, .height], constant: 16)
    locationLabel.addInnerConstraint([.trailing, .top, .bottom], constant: 0)
    locationLabel.relateTo(locationLogo, relative: .right, constant: 4)
    locationLogo.relateTo(locationLabel, relative: .alignCenterY, constant: 0)

    stackView.addArrangedSubview(userCardView)
    userCardView.addInnerConstraint([.leading, .trailing], constant: 0)

    userStatsContainer.addArrangedSubview(followerStatView)
    userStatsContainer.addArrangedSubview(followingStatView)

    stackView.addArrangedSubview(userStatsContainer)
    stackView.addArrangedSubview(userBioContainer)
    stackView.addArrangedSubview(bioHeader)
    bioHeader.addInnerConstraint([.leading, .trailing], constant: 0)
    stackView.addArrangedSubview(bioTextView)
    bioTextView.addInnerConstraint([.leading, .trailing, .bottom], constant: 0)
  }
  
  override func configuration() {
    viewModel.fetchUserDetails()
  }
}

extension GithubUserDetailsVC: GithubUserDetailsInput {
  func updateUserDetails(user: GithubUserDetails) {
    locationLabel.text = user.location
    userCardView.update(config: UserCardViewConfig(title: user.userName, url: user.avatarURL))
    followerStatView.update(config: StatViewConfig(stat: "\(user.followers)", unit: "followers", iconName: "followers"))
    followingStatView.update(config: StatViewConfig(stat: "\(user.followings)", unit: "followings", iconName: "following"))
    
    bioTextView.text = "aetet"
  }
}
