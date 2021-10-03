//
//  CouponCell.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 19/09/2021.
//

import UIKit

class CouponCell: UITableViewCell {
    
    var indexPath: IndexPath?
    
    var coupon: Coupon? {
        didSet {
            websiteLabel.attributedText = NSAttributedString(string: (coupon?.website)!, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
            discountLabel.text = coupon?.discount
            expirationLabel.text = coupon?.expiration
            notesLabel.text = coupon?.notes
            couponCodeLabel.text = coupon?.code
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
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame = newFrame
            let newWidth = frame.width * 0.9
            let spaceWidth = (frame.width - newWidth) / 2
            frame.size.width = newWidth
            frame.origin.x += spaceWidth
            
            let newHeight = frame.height * 0.9
            let spaceHeight = (frame.height - newHeight) / 2
            frame.size.height = newHeight
            frame.origin.y += spaceHeight
            
            super.frame = frame
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Views
    private lazy var websiteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var discountLabel: UILabel = {
        let label = UILabel()
        
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        
        return label
    }()
    
    private lazy var expirationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var notesSupportLabel: UILabel = {
        let label = UILabel()
        label.text = "notes"
        label.font = UIFont.systemFont(ofSize: 6)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "square.and.pencil", withConfiguration: config)?.withTintColor(UIColor.CouponTracker.cellButton, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(editCell), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        let config = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "trash", withConfiguration: config)?.withTintColor(UIColor.CouponTracker.cellButton, renderingMode: .alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(deleteCell), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [editButton, deleteButton])
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
        return stackView
    }()
    
    private lazy var couponCodeView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 12.69
        
        return view
    }()
    
    private lazy var couponCodeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        
        return label
        
    }()
    
    // MARK: - Setup methods
    private func setupViews() {
        addSubview(websiteLabel)
        addSubview(discountLabel)
        addSubview(expirationLabel)
        
        addSubview(couponCodeView)
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.frame = bounds
        couponCodeView.addSubview(blurView)
        addSubview(couponCodeLabel)
        
        addSubview(notesSupportLabel)
        addSubview(notesLabel)
        
        addSubview(editButton)
        addSubview(deleteButton)
        
        addSubview(stackView)
    }
    
    private func setupLayout() {
        websiteLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            websiteLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            websiteLabel.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        ])
        
        discountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            discountLabel.topAnchor.constraint(equalTo: websiteLabel.bottomAnchor, constant: 5),
            discountLabel.leadingAnchor.constraint(equalTo: websiteLabel.leadingAnchor),
            
        ])
        
        expirationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            expirationLabel.topAnchor.constraint(equalTo: discountLabel.bottomAnchor, constant: 5),
            expirationLabel.leadingAnchor.constraint(equalTo: websiteLabel.leadingAnchor)
        ])
        
        couponCodeView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            couponCodeView.topAnchor.constraint(equalTo: expirationLabel.bottomAnchor, constant: 10),
            couponCodeView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            couponCodeView.leadingAnchor.constraint(equalTo: websiteLabel.leadingAnchor),
            couponCodeView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: contentView.frame.width * -0.45)
        ])
        
        couponCodeLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            couponCodeLabel.centerXAnchor.constraint(equalTo: couponCodeView.centerXAnchor),
            couponCodeLabel.centerYAnchor.constraint(equalTo: couponCodeView.centerYAnchor)
        ])
        
        notesSupportLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesSupportLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            notesSupportLabel.leadingAnchor.constraint(equalTo: trailingAnchor, constant: contentView.frame.width * -0.4)
        ])
        
        notesLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            notesLabel.topAnchor.constraint(equalTo: notesSupportLabel.bottomAnchor),
            notesLabel.leadingAnchor.constraint(equalTo: notesSupportLabel.leadingAnchor),
            notesLabel.bottomAnchor.constraint(lessThanOrEqualTo: stackView.topAnchor, constant: 3),
            notesLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor)
        ])
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
    
    // MARK: - Buttons actions
    @objc func editCell() {
        guard let indexPath = indexPath else { return }
        let userInfo: [String: IndexPath] = ["currentCellIndexPath": indexPath]
        NotificationCenter.default.post(name: .beginEditingCoupon, object: nil, userInfo: userInfo)
    }
    
    @objc func deleteCell() {
        guard let indexPath = indexPath else { return }
        let userInfo: [String: IndexPath] = ["currentCellIndexPath": indexPath]
        NotificationCenter.default.post(name: .beginDeletingCoupon, object: nil, userInfo: userInfo)
    }
    
}
