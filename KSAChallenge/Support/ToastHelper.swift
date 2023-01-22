//
//  ToastHelper.swift
//  KSAChallenge
//
//  Created by Ahmed Wahdan on 22/01/2023.
//


import UIKit
import AudioToolbox

final class ToastHelper {

    static func alert(title: String? = nil, message: String? = nil) -> UIAlertController {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .white
        alert.view.layer.cornerRadius = 15
        alert.view.alpha = 0.9
        return alert
    }
    
    static func showAlert(WithMessage msg: String, reloadHandler: (() -> Void)? = nil) {
        let alert = ToastHelper.alert(title: "Hmmm", message: msg)
        alert.addAction(UIAlertAction(title: "Reload", style: .default, handler: { (action) in
            reloadHandler?()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.show(animated: true, vibrate: true, completion: {
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 9.0, execute: {[weak alert] in
                alert?.dismiss(animated: true, completion: nil)
            })
        })
    }
}

extension UIAlertController {
    
    public func show(animated: Bool = true, vibrate: Bool = false, completion: (() -> Void)? = nil) {
        UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }?.rootViewController?.present(self, animated: animated, completion: completion)
        if vibrate {
            AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
        }
    }
}

