//
//  CouponDetailsCell.swift
//  Coupon Tracker
//
//  Created by Krzysztof Kinal on 20/09/2021.
//

import UIKit

class CouponDetailsCell: UITableViewCell, UITextViewDelegate {
    
    var indexPathRow: Int? {
        didSet {
            switch indexPathRow {
            case 0:
                valueLabel.text = "Website"
                valueTextView.tag = 0
            case 1:
                valueLabel.text = "Discount"
                valueTextView.tag = 1
            case 2:
                valueLabel.text = "Expiration"
                valueTextView.tag = 2
            case 3:
                valueLabel.text = "Notes"
                valueTextView.tag = 3
            case 4:
                valueLabel.text = "Code"
                valueTextView.tag = 4
            default:
                ()
            }
        }
    }
    
    var coupon: Coupon? {
        didSet {
            switch indexPathRow {
            case 0:
                valueTextView.text = coupon?.website
            case 1:
                valueTextView.text = coupon?.discount
            case 2:
                valueTextView.text = coupon?.expiration
            case 3:
                valueTextView.text = coupon?.notes
            case 4:
                valueTextView.text = coupon?.code
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
        valueTextView.delegate = self
        
        setupViews()
        setupLayout()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Views
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 17)
        
        return label
    }()
    
    lazy var valueTextView: UITextView = {
        let textView = UITextView()
        textView.isUserInteractionEnabled = true
        textView.returnKeyType = .done
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.textAlignment = .right
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 12.69
        textView.layer.borderWidth = 0.7
        textView.layer.borderColor = UIColor.systemGray4.cgColor
        textView.backgroundColor = UIColor.systemGray6
        
        return textView
    }()
    
    // MARK: - Setup methods
    func setupViews() {
        addSubview(valueLabel)
        addSubview(valueTextView)
    }
    
    func setupLayout() {
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            valueLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        valueTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            valueTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            valueTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            valueTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            valueTextView.widthAnchor.constraint(equalTo: widthAnchor, constant: contentView.bounds.width * -0.33)
        ])
    }
    
    // MARK: - Delegate methods
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            textView.resignFirstResponder()
            return false
        }
        
        switch textView.tag {
        case 0:
            return textView.text.count + (text.count - range.length) <= 12
        case 1:
            return textView.text.count + (text.count - range.length) <= 16
        case 2:
            return textView.text.count + (text.count - range.length) <= 16
        case 3:
            return textView.text.count + (text.count - range.length) <= 100
        case 4:
            return textView.text.count + (text.count - range.length) <= 15
        default:
            return false
        }
    }
    
}
