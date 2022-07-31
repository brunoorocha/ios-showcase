//
//  HomeCollectionViewLayout.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 31/07/22.
//

import UIKit

final class HomeCollectionViewLayout: UICollectionViewFlowLayout {
    private let heightRatio: CGFloat = 4 / 3
    private let padding: CGFloat
    
    var numberOfColumns: Int {
        didSet {
            evaluateItemSize()
        }
    }

    var containerWidth: CGFloat {
        didSet {
            evaluateItemSize()
        }
    }

    init(numberOfColumns: Int, containerWidth: CGFloat, padding: CGFloat = 16) {
        self.numberOfColumns = numberOfColumns
        self.padding = padding
        self.containerWidth = containerWidth
        super.init()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        minimumInteritemSpacing = 16
        minimumLineSpacing = 16
        sectionInset = .init(top: padding, left: padding, bottom: padding, right: padding)
        evaluateItemSize()
    }

    private func evaluateItemSize() {
        let sectionPadding = padding * 2
        let spacing = CGFloat(numberOfColumns - 1) * minimumLineSpacing + sectionPadding
        let width = (containerWidth - spacing) / CGFloat(numberOfColumns)
        let height = ceil(width * heightRatio)
        itemSize = .init(width: width, height: height)
    }
}

