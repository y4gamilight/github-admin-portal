//
//  Data+Extension.swift
//  GithubAdminPortal
//
//  Created by Thanh Le Tan [C] on 28/10/24.
//
import UIKit
import Foundation

extension Data {
  func resizeImage(withSize newSize: CGSize) -> Data {
    let data = self
    guard let originalImage = UIImage(data: data) else {
      return data
    }
    
    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
    
    originalImage.draw(in: CGRect(origin: .zero, size: newSize))
    
    guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else {
      UIGraphicsEndImageContext()
      return data
    }
    UIGraphicsEndImageContext()
    
    return resizedImage.pngData() ?? data
  }
}
