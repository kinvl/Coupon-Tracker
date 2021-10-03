//
//  NavigationController.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 18/09/2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(viewsNeedUpdate), name: .viewsNeedUpdate, object: nil)
        
        setupNavigationBar()
        
    }
    
    private func setupNavigationBar() {
        self.navigationBar.prefersLargeTitles = true
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.CouponTracker.navigationBar
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        switch traitCollection.userInterfaceStyle {
        case .light:
            isInDarkMode = false
        case .dark:
            isInDarkMode = true
        case .unspecified:
            isInDarkMode = false
        @unknown default:
            isInDarkMode = false
        }
        
        NotificationCenter.default.post(name: .viewsNeedUpdate, object: nil)
    }
    
    @objc private func viewsNeedUpdate() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor.CouponTracker.navigationBar
        self.navigationBar.scrollEdgeAppearance = appearance
    }
    
}
