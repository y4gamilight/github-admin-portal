//
//  StatView.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 26/10/24.
//

import UIKit

struct StatViewConfig {
  let stat: Int
  let unit: String
  let iconName: String?
}

class StatView: UIView {
  enum Constant {
    static let iconSize: CGFloat = 24
    static let containerSize: CGFloat = 44
    static let smallPadding: CGFloat = 8
  }
  private var config: StatViewConfig
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView().forAutolayout()
    stackView.axis = .vertical
    stackView.distribution = .fill
    stackView.alignment = .center
    stackView.spacing = Constant.smallPadding
    return stackView
  }()
  
  private lazy var statContainer: UIView = {
    let view = UIView().forAutolayout()
    view.backgroundColor = Colors.secondaryBg
    view.layer.cornerRadius = Constant.containerSize / 2
    return view
  }()

  private lazy var statIcon: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    if let image = config.iconName {
      imageView.image = UIImage(named: image)
    }
    return imageView
  }()

  private lazy var statLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = roundNumberOfStat(config.stat)
    label.font = Fonts.subtitle
    label.textColor = .black
    return label
  }()

  private lazy var unitLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = config.unit
    label.font = Fonts.subtitle
    label.textColor = .black
    return label
  }()

  init(config: StatViewConfig) {
    self.config = config
    super.init(frame: .zero)
    setupViews()
  }
   
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setupViews() {
    addSubview(stackView)
    stackView.addArrangedSubview(statContainer)
    stackView.addArrangedSubview(statLabel)
    stackView.addArrangedSubview(unitLabel)
    stackView.addInnerConstraint([.top, .bottom, .leading, .trailing], constant: 0)
    statContainer.addInnerConstraint([.width, .height], constant: Constant.containerSize)
    statContainer.addSubview(statIcon)
    statIcon.addInnerConstraint([.width, .height], constant: Constant.iconSize)
    statIcon.addInnerConstraint([.centerX, .centerY], constant: 0)
  }

  func update(config: StatViewConfig) {
    self.config = config
    self.statLabel.text = roundNumberOfStat(config.stat)
    self.unitLabel.text = config.unit
    if let image = config.iconName {
      self.statIcon.image = UIImage(named: image)
    }
  }

  private func roundNumberOfStat(_ number: Int) -> String {
    if number > 1000 {
      return "1000+"
    } else if number > 100 {
      return "100+"
    } else if number > 10 {
      return "10+"
    }
    return "\(number)"
  }
}
