//
//  Notification.Name+CustomNames.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 20/09/2021.
//

import Foundation

extension Notification.Name {
    static let shouldReloadTable = Notification.Name("shouldReloadTable")
    static let shouldDismiss = Notification.Name("shouldDismiss")
    static let performButtonTask = Notification.Name("performButtonTask")
    static let beginEditingCoupon = Notification.Name("beginEditingCoupon")
    static let beginDeletingCoupon = Notification.Name("beginDeletingCoupon")
    static let viewsNeedUpdate = Notification.Name("viewsNeedUpdate")
}
