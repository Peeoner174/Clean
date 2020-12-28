//
//  Reusable.swift
//  CleanArhitecture
//
//  Created by MSI on 01/09/2019.
//  Copyright © 2019 IA. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Auto creation reuseIdentifier
protocol Reusable {
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UITableView {
    
    // MARK: Headers
    
    /// Registers a class for use in creating new table header or footer views.
    final func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type) {
        register(headerType.self, forHeaderFooterViewReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Returns a reusable header or footer view object by type
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_ headerType: T.Type = T.self) -> T? {
        guard let header = self.dequeueReusableHeaderFooterView(withIdentifier: headerType.reuseIdentifier) as? T else {
            assertionFailure("Failed to dequeue a header/footer with identifier \(headerType.reuseIdentifier)")
            return nil
        }
        return header
    }
    
    // MARK: Cells
    
    /// Registers a class for use in creating new table cells.
    final func registerReusableCell<T: UITableViewCell>(_ cellType: T.Type) {
        register(cellType.self, forCellReuseIdentifier: T.reuseIdentifier)
    }
    
    /// Returns a reusable table-view cell object and adds it to the table.
    ///
    /// - Parameters:
    ///   - cellType: type for casting cell
    ///   - indexPath: index path specifying the location of the cell
    ///
    ///  -  Return cell. If casting fail return nil for release version and fatalError for debug version
    func dequeueReusableCell<T: UITableViewCell>(_ cellType: T.Type = T.self, forIndexPath indexPath: IndexPath? = nil) -> T? {
        if let indexPath = indexPath {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else {
                assertionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
                return nil
            }
             return cell
        } else {
            guard let cell = self.dequeueReusableCell(withIdentifier: cellType.reuseIdentifier) as? T else {
                assertionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
                return nil
            }
            return cell
        }
    }
    
}

extension UIView: Reusable { }
extension UIViewController: Reusable { }

extension Reusable where Self: UIView {
    
    /// Don't set a nib's owner. Set view's class to the one being loaded.
    static func fromNib() -> Self {
        guard let view = Bundle(for: self).loadNibNamed(Self.reuseIdentifier, owner: nil, options: nil)?[0] as? Self else {
            fatalError()
        }
        return view
    }
    
    /// Set a view class as it's nib owner. Don't set any class to the view itself.
    /// Your view will act as a content view.
    func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Self.reuseIdentifier, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView else {
            fatalError()
        }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
        
        return view
    }
    
}
