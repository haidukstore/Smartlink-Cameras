//
//  UIWindow+Extensions.swift
//  Smartlink
//
//  Created by Minhaz Mohammad on 11/30/18.
//  Copyright © 2018 SecureNet Technologies, LLC. All rights reserved.
//

import UIKit

extension UIWindow {
    
    struct FadeInTransitionOptions {
        
        var animation: CATransition {
            let transition = CATransition()
            transition.type = .fade
            transition.subtype = nil
            transition.duration = transitionDuration
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            return transition
        }
        var transitionDuration: TimeInterval
        
        init(transitionDuration: TimeInterval = 0.3) {
            self.transitionDuration = transitionDuration
        }
        
    }
    
    func setRootViewController(_ controller: UIViewController) {
        let backgroundView: UIView = controller.view
        let options: FadeInTransitionOptions = FadeInTransitionOptions()
        let transitionWindow: UIWindow? = nil
        
        transitionWindow?.rootViewController = UIViewController.newController(withView: backgroundView, frame: transitionWindow!.bounds)
        transitionWindow?.makeKeyAndVisible()
        
        layer.add(options.animation, forKey: kCATransition)
        rootViewController = controller
        makeKeyAndVisible()
        
        if let window = transitionWindow {
            DispatchQueue.main.asyncAfter(deadline: (.now() + 1 + options.transitionDuration), execute: {
                window.removeFromSuperview()
            })
        }
    }
    
}

extension UIViewController {
    
    static func newController(withView view: UIView, frame: CGRect) -> UIViewController {
        view.frame = frame
        let controller = UIViewController()
        controller.view = view
        return controller
    }
    
}

extension UIColor {
    
    static var textfieldTintColor: UIColor {
        UIColor(red: 42/255, green: 60/255, blue: 67/255, alpha: 1)
    }
    
    static var signInButtonBackground: UIColor {
        UIColor(red: 71/255, green: 106/255, blue: 119/255, alpha: 1)
    }
}
