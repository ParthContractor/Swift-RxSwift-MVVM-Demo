//
//  UIViewControllerExtension.swift
//  Swift-RxSwift-MVVM-Demo
//
//  Created by Parth on 24/11/19.
//  Copyright © 2019 Parth. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

//TODO: To be optimised
var loadingIndicatorView : UIView?//extensions can not containe stored property hence temporary workaround for utilising reusable loading indicator through extension

extension UIViewController {
    func presentAlert(withTitle title: String, message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func showLoadingIndicator(onView : UIView) {
        let loadingView = UIView.init(frame: onView.bounds)
        let ai: UIActivityIndicatorView!
        if #available(iOS 13.0, *) {
            ai = UIActivityIndicatorView.init(style: .medium)
        }
        else{
            ai = UIActivityIndicatorView.init(style: .gray)
        }
        ai.backgroundColor = .clear
        ai.startAnimating()
        ai.center = loadingView.center
        
        DispatchQueue.main.async {
            loadingView.addSubview(ai)
            onView.addSubview(loadingView)
        }
        
        loadingIndicatorView = loadingView
    }
    
    func removeLoadingIndicator() {
        DispatchQueue.main.async {
            loadingIndicatorView?.removeFromSuperview()
            loadingIndicatorView = nil
        }
    }

}

extension Reactive where Base: UIViewController {
    
    /// Bindable for `showLoadingIndicator()`, `removeLoadingIndicator()` methods.
    public var isAnimating: Binder<Bool> {
        return Binder(self.base, binding: { (vc, active) in
            if active {
                vc.showLoadingIndicator(onView: vc.view)
            } else {
                vc.removeLoadingIndicator()
            }
        })
    }
    
}
