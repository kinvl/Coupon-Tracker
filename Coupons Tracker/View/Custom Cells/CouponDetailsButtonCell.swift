//
//  CouponDetailsButtonCell.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 22/09/2021.
//

import UIKit

class CouponDetailsButtonCell: UITableViewCell {
    
    var do_I_Edit: Bool? {
        didSet {
            switch do_I_Edit {
            case true:
                actionButton.setTitle("Edit", for: .normal)
            case false:
                actionButton.setTitle("Add", for: .normal)
            default:
                ()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.isUserInteractionEnabled = true
        
        setupViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Views
    lazy var actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor.CouponTracker.detailsButton
        button.setTitleColor(UIColor.label, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.69
        button.addTarget(self, action: #selector(performButtonTask), for: .touchUpInside)
        
        return button
    }()
    
    lazy var exitButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemGray4
        button.setTitleColor(UIColor.label, for: .normal)
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 12.69
        button.addTarget(self, action: #selector(shouldDismiss), for: .touchUpInside)
        
        return button
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [actionButton, exitButton])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 3
        
        return stackView
    }()
    
    // MARK: - Setup methods
    func setupViews() {
        addSubview(actionButton)
        addSubview(exitButton)
        addSubview(stackView)
    }
    
    func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    // MARk: - NC methods
    @objc func performButtonTask() {
        guard let do_I_Edit = do_I_Edit  else { return }
        let userInfo: [String: Bool] = ["do_I_Edit": do_I_Edit]
        NotificationCenter.default.post(name: .performButtonTask, object: nil, userInfo: userInfo)
    }
    
    @objc func shouldDismiss() {
        NotificationCenter.default.post(name: .shouldDismiss, object: nil)
    }
    
}
