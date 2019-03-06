//
//  PlaceholderTextView.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/7/28.
//  Copyright © 2018年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


class PlaceholderTextView: UITextView {

    // MARK: - IBInspectable Property -
    @IBInspectable var placeholder: String = "" {
        didSet {
            placeholderLabel.text = placeholder
            setNeedsDisplay()
        }
    }
    @IBInspectable var placeholderColor: UIColor = .lightGray {
        didSet {
            placeholderLabel.textColor = placeholderColor
            setNeedsDisplay()
        }
    }

    // MARK: - Public Property -
    public var placeholderAlignment: NSTextAlignment = .left {
        didSet {
            placeholderLabel.textAlignment = placeholderAlignment
            setNeedsDisplay()
        }
    }
    // MARK: - Private Property -
    private var placeholderLabel = UILabel()

    // MARK: - Override Methods -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    override func draw(_ rect: CGRect) {
        // Drawing code
        if !placeholder.isEmpty {
            placeholderLabel.text = placeholder
            placeholderLabel.textColor = placeholderColor
            placeholderLabel.textAlignment = placeholderAlignment
        }
        display()
        super.draw(rect)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        let labelSize = placeholderLabel.sizeThatFits(CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude))
        placeholderLabel.frame = CGRect(x: 6, y: 6, width: labelSize.width, height: labelSize.height)
    }

    // MARK: - Override Methods -
    // MARK: - Initialize Methods -
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - Configuration Methods -
    private func configure() {
        configuePlaceholder()
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange(notification:)), name: UITextView.textDidChangeNotification, object: self)
    }

    private func configuePlaceholder() {
        placeholderLabel.backgroundColor = .clear
        placeholderLabel.lineBreakMode = .byCharWrapping
        placeholderLabel.numberOfLines = 0
        placeholderLabel.font = font
        addSubview(placeholderLabel)
    }

}


// MARK: - Event Methods -
extension PlaceholderTextView {

    @objc private func textDidChange(notification: NSNotification) {
        guard let _ = notification.object as? PlaceholderTextView else { return }
        updateLayout()
        display()
    }

}


// MARK: - Public Methods -
extension PlaceholderTextView {
}


// MARK: - Private Methods -
extension PlaceholderTextView {

    private func updateLayout() {
        invalidateIntrinsicContentSize()
        scrollRangeToVisible(selectedRange)
    }

    private func display() {
        placeholderLabel.isHidden = !text.isEmpty
    }

}

