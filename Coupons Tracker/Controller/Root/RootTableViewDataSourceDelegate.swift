//
//  RootTableViewDataSourceDelegate.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 19/09/2021.
//

import UIKit

extension RootViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coupons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CouponCell
        cell.selectionStyle = .none
        
        cell.layer.cornerRadius = 12.69
        cell.backgroundColor = UIColor.CouponTracker.cell
        
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowRadius = 3.0
        cell.layer.shadowOffset = CGSize(width: 3, height: 3)
        cell.layer.shadowOpacity = 0.4
        
        let currentItem = coupons[indexPath.row]
        cell.coupon = currentItem
        cell.indexPath = indexPath
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
