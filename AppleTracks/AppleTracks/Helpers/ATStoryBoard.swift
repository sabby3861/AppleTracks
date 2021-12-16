//
//  ATStoryBoard.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 16/12/2021.
//

import Foundation
import UIKit
/// Storyboard exntesion, an utitlity
extension UIStoryboard {
  enum Storyboard: String {
    case Main
    var filename: String {
      return rawValue.capitalized
    }
  }
  convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
    self.init(name: storyboard.filename, bundle: bundle)
  }
  class func storyboard(storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
    return UIStoryboard(name: storyboard.filename, bundle: bundle)
  }
  
  func instantiateVieController<T>() -> T where T: LFStoryboardIdentifiable {
    guard let viewController = self.instantiateViewController(withIdentifier: T.storyboardIdentifier) as? T else {
      fatalError("\(storyboardError) \(T.storyboardIdentifier) ")
    }
    return viewController
  }
  
}


protocol LFStoryboardIdentifiable {
  static var storyboardIdentifier: String { get }
}

extension LFStoryboardIdentifiable where Self: UIViewController {
  static var storyboardIdentifier: String {
    return String(describing: self)
  }
}

extension UIViewController: LFStoryboardIdentifiable{}
