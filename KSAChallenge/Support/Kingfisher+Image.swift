//
//  Kingfisher+Image.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with path: String, placeholder: String = "logo_Placeholder") {
        kf.indicatorType = .activity
        
        let options: KingfisherOptionsInfo = [
            .forceTransition,
            .cacheOriginalImage,
            .scaleFactor(UIScreen.main.scale),
            .processor(DownsamplingImageProcessor(size: bounds.size))
        ]
        let url = path.encode()
        kf.setImage(
            with: URL(string: url),
            placeholder: UIImage(named: placeholder),
            options: options
        )
    }
    
}

extension String {
    
    func encode() -> String {
        addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
    }
    
}
