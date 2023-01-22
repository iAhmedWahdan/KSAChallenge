//
//  UIView+NVActivityIndicatorView.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit
import NVActivityIndicatorView

extension UIView {
    @objc func showActivityIndicator(color: UIColor = .orange, centerOffSet: UIOffset = .zero) {
        var activityIndicator = viewWithTag(98_765_354) as? NVActivityIndicatorView
        
        if activityIndicator == nil {
            let frame = CGRect(x: 0, y: 0, width: 60, height: 60)
            activityIndicator = NVActivityIndicatorView(frame: frame, type: .lineScale, padding: 10)
            
            activityIndicator?.color = color
            
            activityIndicator?.tag = 98_765_354
            
            addSubview(activityIndicator!)
            
            activityIndicator?.translatesAutoresizingMaskIntoConstraints = false
            
            activityIndicator?.centerXAnchor.constraint(equalTo: centerXAnchor, constant: centerOffSet.horizontal).isActive = true
            activityIndicator?.centerYAnchor.constraint(equalTo: centerYAnchor, constant: centerOffSet.vertical).isActive = true
            activityIndicator?.heightAnchor.constraint(equalToConstant: min(60, self.frame.height)).isActive = true
            
            if let button = self as? UIButton {
                activityIndicator?.color = button.currentTitleColor
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                    button.titleLabel?.isHidden = true
                }
            }
        }
        
        activityIndicator?.startAnimating()
    }
    
    @objc func hideActivityIndicator() {
        if let activityIndicator = viewWithTag(98_765_354) as? NVActivityIndicatorView {
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
                
                if let button = self as? UIButton {
                    button.titleLabel?.isHidden = false
                }
            }
        }
    }
}
