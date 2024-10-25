//
//  UIView+Layout.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 25/10/24.
//

import UIKit

//Constraint relate to superview
struct InnerConstraint: OptionSet {
  let rawValue: Int
  init(rawValue: Int) {
    self.rawValue = rawValue
  }
  
  static let top = InnerConstraint(rawValue: 1 << 0)
  static let left = InnerConstraint(rawValue: 1 << 1)
  static let bottom = InnerConstraint(rawValue: 1 << 2) //bottom padding to contaner's bottom
  static let right = InnerConstraint(rawValue: 1 << 3)  //right padding to contaner's right
  static let centerX = InnerConstraint(rawValue: 1 << 4)
  static let centerY = InnerConstraint(rawValue: 1 << 5)
  static let width = InnerConstraint(rawValue: 1 << 6)
  static let height = InnerConstraint(rawValue: 1 << 7)
  static let leading = InnerConstraint(rawValue: 1 << 8)
  static let trailing = InnerConstraint(rawValue: 1 << 9)
  static let safeTop = InnerConstraint(rawValue: 1 << 10)
  static let safeBottom = InnerConstraint(rawValue: 1 << 11)
}

//Constraint relate to sibling
enum RelativeConstraint: Int {
  case up
  case left
  case right
  case down
  case width
  case height
  case alignTop
  case alignLeft
  case alignRight
  case alignBottom
  case alignCenterX
  case alignCenterY
}


extension UIView {
  //Add constrants relate to superview
  @discardableResult
  func addInnerConstraint(_ constraint: InnerConstraint, constant: CGFloat?, priority: UILayoutPriority? = nil, relatedBy: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1) -> [NSLayoutConstraint] {
    translatesAutoresizingMaskIntoConstraints = false
    var constraints: [NSLayoutConstraint] = []
    defer {
      if let priority = priority {
        constraints.forEach { constraint in constraint.priority = priority }
      }
      NSLayoutConstraint.activate(constraints)
    }
    if constraint.contains(.width), let width = constant {
      switch relatedBy {
      case .equal:
        constraints.append(widthAnchor.constraint(equalToConstant: width))
      case .greaterThanOrEqual:
        constraints.append(widthAnchor.constraint(greaterThanOrEqualToConstant: width))
      case .lessThanOrEqual:
        constraints.append(widthAnchor.constraint(lessThanOrEqualToConstant: width))
      @unknown default:
        assertionFailure("Unexpected type: \(relatedBy)")
      }
    }
    if constraint.contains(.height), let height = constant {
      switch relatedBy {
      case .equal:
        constraints.append(heightAnchor.constraint(equalToConstant: height))
      case .greaterThanOrEqual:
        constraints.append(heightAnchor.constraint(greaterThanOrEqualToConstant: height))
      case .lessThanOrEqual:
        constraints.append(heightAnchor.constraint(lessThanOrEqualToConstant: height))
      @unknown default:
        assertionFailure("Unexpected type \(relatedBy)")
      }
    }
    
    guard let superView = self.superview else { return constraints }
    if let constant = constant {
      if constraint.contains(.top) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .top, relatedBy: relatedBy,
                                              toItem: superView, attribute: .top, multiplier: 1, constant: constant))
      }
      if constraint.contains(.left) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .left, relatedBy: relatedBy,
                                              toItem: superView, attribute: .left, multiplier: 1, constant: constant))
      }
      if constraint.contains(.leading) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .leading, relatedBy: relatedBy,
                                              toItem: superView, attribute: .leading, multiplier: 1, constant: constant))
      }
      if constraint.contains(.safeTop) {
        let topConstraint: NSLayoutConstraint
        switch relatedBy {
        case .greaterThanOrEqual:
          topConstraint = topAnchor.constraint(greaterThanOrEqualTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant)
        case .lessThanOrEqual:
          topConstraint = topAnchor.constraint(lessThanOrEqualTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant)
        case .equal:
          topConstraint = topAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.topAnchor, constant: constant)
        @unknown default:
          fatalError("Unexpected type of NSLayoutConstraint.Relation: \(relatedBy)")
        }
        topConstraint.isActive = true
        constraints.append(topConstraint)
      }
      let translateRelatedBy = { (relatedBy: NSLayoutConstraint.Relation) -> NSLayoutConstraint.Relation in
        let translatedRelatedBy: NSLayoutConstraint.Relation
        switch relatedBy {
        case .lessThanOrEqual:
          translatedRelatedBy = .greaterThanOrEqual
        case .greaterThanOrEqual:
          translatedRelatedBy = .lessThanOrEqual
        default:
          translatedRelatedBy = .equal
        }
        return translatedRelatedBy
      }
      if constraint.contains(.bottom) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: translateRelatedBy(relatedBy),
                                              toItem: superView, attribute: .bottom, multiplier: 1, constant: -constant))
      }
      if constraint.contains(.right) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .right, relatedBy: translateRelatedBy(relatedBy),
                                              toItem: superView, attribute: .right, multiplier: 1, constant: -constant))
      }
      if constraint.contains(.trailing) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: translateRelatedBy(relatedBy),
                                              toItem: superView, attribute: .trailing, multiplier: 1, constant: -constant))
      }
      if constraint.contains(.centerX) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .centerX, relatedBy: .equal,
                                              toItem: superView, attribute: .centerX, multiplier: 1, constant: constant))
      }
      if constraint.contains(.centerY) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .centerY, relatedBy: .equal,
                                              toItem: superView, attribute: .centerY, multiplier: 1, constant: constant))
      }
      if constraint.contains(.safeBottom) {
        let bottomConstraint: NSLayoutConstraint
        switch relatedBy {
        case .greaterThanOrEqual:
          bottomConstraint = bottomAnchor.constraint(lessThanOrEqualTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        case .lessThanOrEqual:
          bottomConstraint = bottomAnchor.constraint(greaterThanOrEqualTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        case .equal:
          bottomConstraint = bottomAnchor.constraint(equalTo: superView.safeAreaLayoutGuide.bottomAnchor, constant: -constant)
        @unknown default:
          fatalError("Unexpected type of ()")
        }
        bottomConstraint.isActive = true
        constraints.append(bottomConstraint)
      }
    } else {
      if constraint.contains(.width) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .width, relatedBy: relatedBy,
                                              toItem: superView, attribute: .width, multiplier: multiplier, constant: 0))
      }
      if constraint.contains(.height) {
        constraints.append(NSLayoutConstraint(item: self, attribute: .height, relatedBy: relatedBy,
                                              toItem: superView, attribute: .height, multiplier: multiplier, constant: 0))
      }
    }
    return constraints
  }
  
  //Add around padding constrants relate to superview
  @objc @discardableResult
  func addInnerConstraint(_ edges: UIEdgeInsets) -> [NSLayoutConstraint] {
    guard let superView = self.superview else { return [] }
    translatesAutoresizingMaskIntoConstraints = false
    let constraints: [NSLayoutConstraint] = [
      NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal,
                         toItem: superView, attribute: .top, multiplier: 1, constant: edges.top),
      NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal,
                         toItem: superView, attribute: .left, multiplier: 1, constant: edges.left),
      NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal,
                         toItem: superView, attribute: .bottom, multiplier: 1, constant: -edges.bottom),
      NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal,
                         toItem: superView, attribute: .right, multiplier: 1, constant: -edges.right)
    ]
    NSLayoutConstraint.activate(constraints)
    return constraints
  }
  
  @objc @discardableResult
  func addConstraint(_ attr1: NSLayoutConstraint.Attribute, toItem: UIView?, attr2: NSLayoutConstraint.Attribute, constant: CGFloat, relatedBy: NSLayoutConstraint.Relation = .equal, multiplier: CGFloat = 1) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let constraint = NSLayoutConstraint(item: self, attribute: attr1, relatedBy: relatedBy, toItem: toItem, attribute: attr2, multiplier: multiplier, constant: constant)
    constraint.isActive = true
    return constraint
  }
  
  //Add constraint relate to sibling
  @discardableResult
  func relateTo(_ view: UIView,
                relative: RelativeConstraint,
                constant: CGFloat,
                relatedBy: NSLayoutConstraint.Relation = .equal,
                multiplier: CGFloat = 1,
                priority: UILayoutPriority = .required) -> NSLayoutConstraint {
    translatesAutoresizingMaskIntoConstraints = false
    let realConstant: CGFloat
    let realRelatedBy: NSLayoutConstraint.Relation
    switch relative {
    case .up, .left:
      realConstant = -constant
      switch relatedBy {
      case .greaterThanOrEqual:
        realRelatedBy = .lessThanOrEqual
      case .lessThanOrEqual:
        realRelatedBy = .greaterThanOrEqual
      default:
        realRelatedBy = relatedBy
      }
    default:
      realConstant = constant
      realRelatedBy = relatedBy
    }
    let attr1: NSLayoutConstraint.Attribute
    let attr2: NSLayoutConstraint.Attribute
    switch relative {
    case .up:
      attr1 = .bottom
      attr2 = .top
    case .down:
      attr1 = .top
      attr2 = .bottom
    case .left:
      attr1 = .right
      attr2 = .left
    case .right:
      attr1 = .left
      attr2 = .right
    case .width:
      attr1 = .width
      attr2 = .width
    case .height:
      attr1 = .height
      attr2 = .height
    case .alignTop:
      attr1 = .top
      attr2 = .top
    case .alignLeft:
      attr1 = .left
      attr2 = .left
    case .alignRight:
      attr1 = .right
      attr2 = .right
    case .alignBottom:
      attr1 = .bottom
      attr2 = .bottom
    case .alignCenterX:
      attr1 = .centerX
      attr2 = .centerX
    case .alignCenterY:
      attr1 = .centerY
      attr2 = .centerY
    }
    
    let constraint = NSLayoutConstraint(item: self, attribute: attr1, relatedBy: realRelatedBy, toItem: view, attribute: attr2, multiplier: multiplier, constant: realConstant)
    constraint.priority = priority
    constraint.isActive = true
    return constraint
  }
  
}
