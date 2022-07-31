//
//  Reusable.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 31/07/22.
//

import UIKit

protocol Reusable: AnyObject {
    static var reusableIdentifier: String { get }
}

extension Reusable {
    static var reusableIdentifier: String {
        return String(describing: Self.self)
    }
}

extension UICollectionView {
    func register<T: Reusable>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: cellClass.reusableIdentifier)
    }
}
