//
//  Loader.swift
//  CoronaStats
//
//  Created by Rajesh Rajesh on 06/12/22.
//

import UIKit

public class Loader {
    // MARK: - Properties
    static let shared = Loader()
    private init(){}
    
    // MARK: - function
    func showLoadingView(_ show: Bool) {
        DispatchQueue.main.async {
            let existingView = UIApplication.shared.windows[0].viewWithTag(1200)
        
            if show {
                if existingView != nil {
                    return
                }
                let loadingView = self.makeLoadingView(withFrame: UIScreen.main.bounds)
                loadingView?.tag = 1200
                UIApplication.shared.windows[0].addSubview(loadingView!)
            } else {
                existingView?.removeFromSuperview()
            }
        }
    }

    private func makeLoadingView(withFrame frame: CGRect) -> UIView? {
        let loadingView = UIView(frame: frame)
        loadingView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        //activityIndicator.backgroundColor = UIColor(red:0.16, green:0.17, blue:0.21, alpha:1)
        activityIndicator.layer.cornerRadius = 6
        activityIndicator.center = loadingView.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        activityIndicator.tag = 100 // 100 for example
        
        loadingView.addSubview(activityIndicator)
        return loadingView
    }
}
