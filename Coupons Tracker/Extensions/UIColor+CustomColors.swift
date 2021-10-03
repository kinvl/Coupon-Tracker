//
//  UIColor+CustomColors.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 22/09/2021.
//

import UIKit

extension UIColor {
    struct CouponTracker {
        static var navigationBar: UIColor { return isInDarkMode ? UIColor(displayP3Red: 0.21, green: 0.00, blue: 0.40, alpha: 1.00) : UIColor(displayP3Red: 1.00, green: 0.55, blue: 0.20, alpha: 1) }
        static var cell: UIColor { return isInDarkMode ? UIColor(displayP3Red: 58/255, green: 30/255, blue: 104/255, alpha: 1) : UIColor(displayP3Red: 1.00, green: 0.66, blue: 0.30, alpha: 1) }
        static var button: UIColor { return isInDarkMode ? UIColor(displayP3Red: 123/255, green: 91/255, blue: 182/255, alpha: 1) : UIColor(displayP3Red: 1.00, green: 0.73, blue: 0.30, alpha: 1)}
        static var detailsButton: UIColor { return isInDarkMode ? UIColor(displayP3Red: 0.26, green: 0.00, blue: 0.50, alpha: 1) : UIColor(displayP3Red: 1.00, green: 0.64, blue: 0.36, alpha: 1.00)}
        static var cellButton: UIColor { return isInDarkMode ? UIColor(displayP3Red: 1.00, green: 0.66, blue: 0.30, alpha: 1) : UIColor(displayP3Red: 58/255, green: 30/255, blue: 104/255, alpha: 1)}
    }
    
}

