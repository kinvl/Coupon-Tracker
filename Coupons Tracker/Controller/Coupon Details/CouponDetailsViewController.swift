//
//  CouponDetailsViewController.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 20/09/2021.
//

import UIKit

class CouponDetailsViewController: UIViewController {
    
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coupons: [Coupon] = [Coupon]()
    var currentCellIndexPathForEditing: IndexPath? { // If this is nil then this VC will act as a coupon creator
        didSet {
            titleLabel.text = "Edit"
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(performButtonTask(_:)), name: .performButtonTask, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewsNeedUpdate), name: .viewsNeedUpdate, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(shouldDismiss), name: .shouldDismiss, object: nil)
        
        fetchTableData()
        setupViews()
        setupLayout()
        
    }
    
    // MARK: - Views and other UI elements
    private lazy var backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.CouponTracker.navigationBar
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12.69
        
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .insetGrouped)
        table.layer.masksToBounds = true
        table.layer.cornerRadius = 12.69
        table.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        table.isScrollEnabled = false
        table.allowsSelection = false
        
        table.delegate = self
        table.dataSource = self
        table.register(CouponDetailsCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        
        return label
    }()
    
    private lazy var tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(sender:)))
    
    // MARK: - Setup methods
    private func setupViews() {
        view.backgroundColor = .clear
        view.addSubview(backgroundView)
        view.addSubview(titleLabel)
        view.addSubview(tableView)
        
        self.view.addGestureRecognizer(tapRecognizer)
    }
    
    private func setupLayout() {
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * (1/27)),
            backgroundView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            backgroundView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: view.frame.width * -0.05),
            backgroundView.heightAnchor.constraint(equalTo: tableView.heightAnchor)
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 15)
        ])
        
        tableView.layoutIfNeeded()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            tableView.heightAnchor.constraint(equalToConstant: tableView.contentSize.height + 90),
            tableView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor)
        ])
    }
    
    // MARK: - Coupons and Core Data related methods
    @objc private func fetchTableData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        do {
            self.coupons = try managedContext.fetch(Coupon.fetchRequest())
        } catch {
            fatalError("Can't fetch data from Core Data.")
        }
    }
    
    @objc private func performButtonTask(_ notification: Notification) {
        guard let do_I_Edit = notification.userInfo?["do_I_Edit"] as? Bool else { return }
        var values: [String] = []
        for row in 0...4 {
            let cell = tableView.cellForRow(at: [0,row]) as! CouponDetailsCell
            guard let value = cell.valueTextView.text, cell.valueTextView.text.isEmpty == false else {
                cell.valueTextView.shake()
                cell.valueTextView.animateBorder(toColor: .red, toWidth: 1, duration: 0.3)
                return
            }
            values.append(value)
            
        }
        switch do_I_Edit {
        case true:
            guard let indexPath = currentCellIndexPathForEditing else { return }
            let object = coupons[indexPath.row]
            
            object.website = values[0]
            object.discount = values[1]
            object.expiration = values[2]
            object.notes = values[3]
            object.code = values[4]
            
            do {
                try managedContext.save()
                NotificationCenter.default.post(name: .shouldReloadTable, object: nil)
            } catch  {
                ()
            }
            self.dismiss(animated: true, completion: nil)
            
        case false:
            let object = Coupon(context: managedContext)
            
            object.website = values[0]
            object.discount = values[1]
            object.expiration = values[2]
            object.notes = values[3]
            object.code = values[4]
            
            do {
                try managedContext.save()
                NotificationCenter.default.post(name: .shouldReloadTable, object: nil)
            } catch  {
                ()
            }
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    // MARK: - Delegate and NC methods
    @objc private func dismissKeyboard(sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @objc private func shouldDismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func viewsNeedUpdate() {
        backgroundView.backgroundColor = UIColor.CouponTracker.navigationBar
        let buttonCell = tableView.cellForRow(at: [0,5]) as? CouponDetailsButtonCell
        buttonCell?.actionButton.backgroundColor = UIColor.CouponTracker.detailsButton
    }
}
