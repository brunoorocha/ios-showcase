//
//  AsyncImageView.swift
//  ios-showcase
//
//  Created by Bruno Rocha da Silva on 31/07/22.
//

import UIKit

final class AsyncImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(from url: URL) {
        image = nil
        alpha = 0
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url), let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self?.image = image
                UIView.animate(withDuration: 0.3) {
                    self?.alpha = 1
                }
            }
        }
    }
}
