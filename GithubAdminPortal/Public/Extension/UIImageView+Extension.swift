//
//  UIImageView+Extension.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 29/10/24.
//

import UIKit

extension UIImageView {
  public func imageFromURLString(_ urlString: String,
                                 defaultImage : String? = nil) {
    guard let url = URL(string: urlString) else { return }
    URLSession.shared.dataTask(with: url, completionHandler: {[weak self] (data, response, error) -> Void in
      var image: UIImage?
      if let data = data {
        image = UIImage(data: data)
      } else if let placeHolderImage = defaultImage {
        image = UIImage(named: placeHolderImage)
      }
      DispatchQueue.main.async(execute: { () -> Void in
        self?.image = image
      })
      
    }).resume()
  }
}
