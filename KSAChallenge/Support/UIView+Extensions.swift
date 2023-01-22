//
//  UIView+Extensions.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 21/01/2023.
//

import UIKit


public extension UIView {
    @IBInspectable var isCircled: Bool {
        get {
            false
        }
        set {
            if newValue {
                cornerRadius = bounds.height / 2
                layer.allowsEdgeAntialiasing = true
                
                if #available(iOS 13.0, *) {
                    layer.cornerCurve = .continuous
                }
                
                DispatchQueue.main.async {
                    self.cornerRadius = self.bounds.height / 2
                }
            }
        }
    }
    
    @IBInspectable var masksToBounds: Bool {
        get {
            layer.masksToBounds
        }
        set {
            layer.masksToBounds = true
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            if #available(iOS 13.0, *) {
                layer.cornerCurve = .continuous
            }
        }
    }

    @IBInspectable var borderColor: UIColor {
        get {
            UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.allowsEdgeAntialiasing = true
            if #available(iOS 13.0, *) {
                self.traitCollection.performAsCurrent {
                    self.layer.borderColor = newValue.cgColor
                }
            } else {
                layer.borderColor = newValue.cgColor
            }
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }

    @IBInspectable var shadowOpacity: Float {
        get {
            layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }

    @IBInspectable var shadowOffset: CGSize {
        get {
            layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }

    @IBInspectable var shadowColor: UIColor {
        get {
            UIColor(cgColor: layer.shadowColor ?? UIColor.lightGray.cgColor)
        }
        set {
            if #available(iOS 13.0, *) {
                self.traitCollection.performAsCurrent {
                    self.layer.shadowColor = newValue.cgColor
                }
            } else {
                layer.shadowColor = newValue.cgColor
            }
        }
    }

    @IBInspectable var shadowRadius: Float {
        get {
            Float(layer.shadowRadius)
        }
        set {
            layer.shadowRadius = CGFloat(newValue)
        }
    }
}
