//
//  ATExtensions.swift
//  AppleTracks
//
//  Created by Sanjay Kumar on 19/12/2021.
//

import Foundation
import UIKit
/// A Helper to remove view from the superview
extension UIView {
    func remove() {
        self.removeFromSuperview()
    }
}

/// Make TableView Cell to use resuable identifier protocol, avoiding writing hard coded identifiers
extension UITableViewCell: ATReusableIdentifier{}

/// An image view extension to download image
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


//Extension to sort out 
extension Sequence {
    func sorted<T: Comparable>(
        by keyPath: KeyPath<Element, T>,
        using comparator: (T, T) -> Bool = (<)
    ) -> [Element] {
        sorted { a, b in
            comparator(a[keyPath: keyPath], b[keyPath: keyPath])
        }
    }
}


// Extension to get String Value
extension LosslessStringConvertible {
    var string: String { .init(self) }
}


// Extension for formatting the date
extension DateFormatter {
    static let yyyyMMdd: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = atDateFormat
        return formatter
    }()
    
    static let dateString: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = atDateStringFormat
        return formatter
    }()
}
