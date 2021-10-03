//
//  CouponDetailsTableViewDataSourceDelegate.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 21/09/2021.
//

import UIKit

extension CouponDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 5 {
            let do_I_edit:Bool = (currentCellIndexPathForEditing != nil)
            let cell = CouponDetailsButtonCell()
            cell.do_I_Edit = do_I_edit
            
            return cell
        }
        
        if currentCellIndexPathForEditing == nil {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CouponDetailsCell
            cell.indexPathRow = indexPath.row
            
            return cell
            
        } else if let currentCellIndexPath = currentCellIndexPathForEditing {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CouponDetailsCell
            
            let currentItem = coupons[currentCellIndexPath.row]
            
            cell.indexPathRow = indexPath.row
            
            cell.coupon = currentItem
            
            return cell
        }
        
        return UITableViewCell.init()
        
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 3:
            return CGFloat(70)
        case 5:
            return CGFloat(103)
        default:
            return CGFloat(50)
        }
    }
    
}
