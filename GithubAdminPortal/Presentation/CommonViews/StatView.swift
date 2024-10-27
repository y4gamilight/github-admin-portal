import UIKit

struct StatViewConfig {
  let stat: String
  let unit: String
  let iconName: String
}

class StatView: UIView {
  enum Constant {
    static let iconSize: CGFloat = 32
  }
  private var config: StatViewConfig
  private lazy var stackView: UIStackView = {
    let stackView = UIStackView().forAutolayout()
    stackView.axis = .vertical
    stackView.spacing = 8
    backgroundColor = .white
    return stackView
  }()

  private lazy var statIcon: UIImageView = {
    let imageView = UIImageView().forAutolayout()
    imageView.image = UIImage(named: config.iconName)
    return imageView
  }()

  private lazy var statLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = config.stat
    label.font = .systemFont(ofSize: 14)
    label.textColor = .black
    return label
  }()

  private lazy var unitLabel: UILabel = {
    let label = UILabel().forAutolayout()
    label.text = config.unit
    label.font = .systemFont(ofSize: 14)
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
    stackView.addArrangedSubview(statIcon)
    stackView.addArrangedSubview(statLabel)
    stackView.addArrangedSubview(unitLabel)
    stackView.addInnerConstraint([.top, .bottom, .leading, .trailing], constant: 0)
    statIcon.addInnerConstraint([.width, .height], constant: Constant.iconSize)
  }

  func update(config: StatViewConfig) {
    self.config = config

    self.statLabel.text = config.stat
    self.unitLabel.text = config.unit
  }
}
