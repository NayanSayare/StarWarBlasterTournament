//
//  UIImageViewExtension.swift
//  StartWarBlasterTournament
//
//  Created by Nayan Sayare on 13/02/24.
//

import UIKit
import SDWebImage

extension UIImageView {
    func setImage(with url: URL?, placeholder: String? = nil) {
        if let placeholderImage = placeholder {
            self.image = UIImage(named: placeholderImage)
        }
        self.sd_setImage(with: url)
    }
}
