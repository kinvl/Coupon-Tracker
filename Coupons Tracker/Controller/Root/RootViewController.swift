//
//  ViewController.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 18/09/2021.
//

import UIKit
import CoreData

class RootViewController: UIViewController {
    
    private let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var coupons: [Coupon] = [Coupon]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Coupons"
        
        NotificationCenter.default.addObserver(self, selector: #selector(fetchTableData), name: .shouldReloadTable, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(beginEditingCoupon(_:)), name: .beginEditingCoupon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(beginDeletingCoupon(_:)), name: .beginDeletingCoupon, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(viewsNeedUpdate), name: .viewsNeedUpdate, object: nil)
        
        setupViews()
        setupLayout()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchTableData()
    }
    
    // MARK: - Views
    private lazy var rightNavigationBarButton: UIButton = {
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .bold)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)?.withTintColor(UIColor.CouponTracker.button, renderingMode: .alwaysOriginal)
        let rightButton = UIButton(type: .system)
        rightButton.setImage(image, for: .normal)
        rightButton.addTarget(self, action: #selector(beginCreatingCoupon), for: .touchUpInside)
        
        return rightButton
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .plain)
        table.register(CouponCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.separatorStyle = .none
        table.allowsSelection = false
        
        return table
    }()
    
    
    private lazy var dummyView: UIView = {
        let dummy = UIView(frame: .zero)
        
        return dummy
    }()
    
    // MARK: - Setup methods
    private func setupViews() {
        self.navigationController?.navigationBar.addSubview(rightNavigationBarButton)
        view.addSubview(tableView)
        view.addSubview(dummyView) // Prevents the large title from collapsing
        view.sendSubviewToBack(dummyView)
    }
    
    
    private func setupLayout() {
        rightNavigationBarButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rightNavigationBarButton.bottomAnchor.constraint(equalTo: (navigationController?.navigationBar.bottomAnchor)!, constant: -10),
            rightNavigationBarButton.trailingAnchor.constraint(equalTo: (navigationController?.navigationBar.trailingAnchor)!, constant: -10)
        ])
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
        
    }
    
    // MARK: - Coupons and Core Data related methods
    @objc private func fetchTableData() {
        do {
            self.coupons = try managedContext.fetch(Coupon.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadSections([0], with: .fade)
            }
            
        } catch {
            fatalError("Can't fetch data from Core Data.")
        }
    }
    
    @objc private func beginCreatingCoupon() {
        let vc = CouponDetailsViewController()
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @objc private func beginEditingCoupon(_ notification: Notification) {
        if let currentCellIndexPath = notification.userInfo?["currentCellIndexPath"] as? IndexPath {
            let vc = CouponDetailsViewController()
            vc.currentCellIndexPathForEditing = currentCellIndexPath
            
            navigationController?.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc private func beginDeletingCoupon(_ notification: Notification) {
        if let currentCellIndexPath = notification.userInfo?["currentCellIndexPath"] as? IndexPath {
            let alert = UIAlertController(title: "Delete coupon?", message: "This action cannot be undone.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {[weak self] _ in
                guard let object = self?.coupons[currentCellIndexPath.row] else { return }
                self?.managedContext.delete(object)
                
                do {
                    try self?.managedContext.save()
                    NotificationCenter.default.post(name: .shouldReloadTable, object: nil)
                } catch  {
                    ()
                }
            }))
            present(alert, animated: true)
        }
    }
    
    // MARK: - NC methods
    @objc private func viewsNeedUpdate() {
        let numberOfCells = tableView.numberOfRows(inSection: 0)
        if numberOfCells > 0 {
            for row in 0...numberOfCells-1 {
                let cell = tableView.cellForRow(at: [0, row]) as? CouponCell
                cell?.backgroundColor = UIColor.CouponTracker.cell
                cell?.editButton.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(UIColor.CouponTracker.cellButton, renderingMode: .alwaysOriginal), for: .normal)
                cell?.deleteButton.setImage(UIImage(systemName: "trash", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))?.withTintColor(UIColor.CouponTracker.cellButton, renderingMode: .alwaysOriginal), for: .normal)
            }
        }
        
        let config = UIImage.SymbolConfiguration(pointSize: 26, weight: .bold)
        let image = UIImage(systemName: "plus.circle.fill", withConfiguration: config)?.withTintColor(UIColor.CouponTracker.button, renderingMode: .alwaysOriginal)
        rightNavigationBarButton.setImage(image, for: .normal)
    }
    
}
