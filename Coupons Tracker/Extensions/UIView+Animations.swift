//
//  UIView+Animations.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 23/09/2021.
//

import UIKit

extension UIView {
    func shake(completion: (() -> Void)? = nil) {
        let speed = 0.75
        let time = 1.0 * speed - 0.15
        let timeFactor = CGFloat(time / 4)
        let animationDelays = [timeFactor, timeFactor * 2, timeFactor * 3]

        let shakeAnimator = UIViewPropertyAnimator(duration: time, dampingRatio: 0.6)
        
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 20, y: 0)
        })
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: -20, y: 0)
        }, delayFactor: animationDelays[0])
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 20, y: 0)
        }, delayFactor: animationDelays[1])
        shakeAnimator.addAnimations({
            self.transform = CGAffineTransform(translationX: 0, y: 0)
        }, delayFactor: animationDelays[2])
        shakeAnimator.startAnimation()

        shakeAnimator.addCompletion { _ in
            completion?()
        }

        shakeAnimator.startAnimation()
    }
    
    func animateBorder(toColor: UIColor, toWidth: CGFloat, duration: Double) {
    let borderColorAnimation = CABasicAnimation(keyPath: "borderColor")
    borderColorAnimation.fromValue = layer.borderColor
    borderColorAnimation.toValue = toColor.cgColor
    borderColorAnimation.duration = duration
    borderColorAnimation.autoreverses = true
    layer.add(borderColorAnimation, forKey: "borderColor")
    
    let borderWidthAnimation: CABasicAnimation = CABasicAnimation(keyPath: "borderWidth")
    borderWidthAnimation.fromValue = layer.borderWidth
    borderWidthAnimation.toValue = toWidth
    borderWidthAnimation.duration = duration
    borderWidthAnimation.autoreverses = true
    layer.add(borderWidthAnimation, forKey: "borderWidth")
  }
    
}
