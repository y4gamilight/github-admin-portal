import UIKit

struct StatViewConfig {
  let stat: String
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
    label.text = config.stat
    label.font = .systemFont(ofSize: 12)
    label.textColor = .black
    return label
  }()

  private lazy var unitLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = config.unit
    label.font = .systemFont(ofSize: 12)
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
    self.statLabel.text = config.stat
    self.unitLabel.text = config.unit
    if let image = config.iconName {
      self.statIcon.image = UIImage(named: image)
    }
  }
}
