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

final class GithubUserDetailsVC: BaseViewController<GithubUserDetailsViewModel>, ViewLoadable {
  enum Constants {
    static let regularPadding: CGFloat = 16
    static let xxSmallPadding: CGFloat = 4
  }
  
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView().forAutolayout()
    stackView.axis = .vertical
    stackView.alignment = .center
    stackView.spacing = Constants.regularPadding
    return stackView
  }()

  private lazy var userCardView: UserCardView = {
    let view = UserCardView(detailView: locationContainer).forAutolayout()
    return view
  }()

  private lazy var locationContainer: UIView = {
    let view = UIView().forAutolayout()
    return view
  }()

  private lazy var locationLogo: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    imageView.image = Images.image(.icLocation)
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
    view.alignment = .fill
    return view
  }()

  private lazy var followerStatView: StatView = {
    let view = StatView(config: .init(stat: "0", unit: "follower", iconName: Images.Name.icFollowers.rawValue)).forAutolayout()
    return view
  }()

  private lazy var followingStatView: StatView = {
    let view = StatView(config: .init(stat: "0", unit: "following", iconName: Images.Name.icFollowings.rawValue)).forAutolayout()
    return view
  }()

  private lazy var userBioContainer: UIView = {
    let view = UIView().forAutolayout()
    return view
  }()
  
  private lazy var bioHeader: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = "Blog"
    label.textColor = Colors.primaryContent
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  private lazy var bioTextView: UITextView = {
    let textView = UITextView().forAutolayout()
    textView.backgroundColor = Colors.primaryBg
    textView.isEditable = false
    textView.textColor = Colors.primaryContent
    textView.font = UIFont.systemFont(ofSize: 14)
    return textView
  }()

  override func setup() { 
    navigationItem.title = "User Details" 
    navigationController?.navigationBar.hideBackTitle()
    view.backgroundColor = Colors.primaryBg
    
    view.addSubview(stackView)
    stackView.addInnerConstraint([.top, .leading, .trailing, .bottom], constant: 0)

    locationContainer.addSubview(locationLogo)
    locationContainer.addSubview(locationLabel)
    locationLogo.addInnerConstraint([.leading], constant: 0)
    locationLogo.addInnerConstraint([.width, .height], constant: Constants.regularPadding)
    locationLogo.addInnerConstraint(.top, constant: Constants.xxSmallPadding)
    locationLabel.addInnerConstraint([.trailing, .top, .bottom], constant: 0)
    locationLabel.relateTo(locationLogo, relative: .right, constant: Constants.xxSmallPadding)
    locationLogo.relateTo(locationLabel, relative: .alignTop, constant: 0)

    stackView.addArrangedSubview(userCardView)
    userCardView.addInnerConstraint([.leading, .trailing], constant: Constants.regularPadding)
    userStatsContainer.addArrangedSubview(followerStatView)
    userStatsContainer.addArrangedSubview(followingStatView)

    stackView.addArrangedSubview(userStatsContainer)
    stackView.addArrangedSubview(userBioContainer)
    stackView.addArrangedSubview(bioHeader)
    userBioContainer.addInnerConstraint([.leading, .trailing], constant: Constants.regularPadding)
    bioHeader.addInnerConstraint([.leading, .trailing], constant: Constants.regularPadding)
    stackView.addArrangedSubview(bioTextView)
    bioTextView.addInnerConstraint([.leading, .trailing, .bottom], constant: Constants.regularPadding)
    bioTextView.addInnerConstraint(.bottom, constant: 0)
    
    userStatsContainer.spacing = view.frame.size.width / 5
  }
  
  override func configuration() {
    viewModel.fetchUserDetails()
  }
}

extension GithubUserDetailsVC: GithubUserDetailsInput {
  func updateUserDetails(user: GithubUserDetails) {
    locationLabel.text = user.location
    userCardView.update(config: UserCardViewConfig(title: user.userName, url: user.avatarURL))
    followerStatView.update(config: StatViewConfig(stat: "\(user.followers)", unit: "Followers", iconName: nil))
    followingStatView.update(config: StatViewConfig(stat: "\(user.followings)", unit: "Followings", iconName: nil))
    
    bioTextView.text = user.blog
  }
}
