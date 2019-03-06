//
//  AttributedLabel.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2018/4/11.
//  Copyright © 2018年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


// MARK: - Initialize Methods -
class AttributedTextView: UITextView {

    typealias Closure = (AttributedTextView, URL) -> Void

    // MARK: - Private Property -
    private var closure: Closure?

    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    // MARK: - Private Methods -
    private func configure() {
        delegate = self
        isSelectable = true
    }

}


// MARK: - Public Methods -
extension AttributedTextView {

    public func addLink(with keywords: [String: URL], taped: Closure?, color: UIColor = .blue, alignment: NSTextAlignment = .center) {
        closure = taped
        if let content = text {
            let attributedContent = NSMutableAttributedString(string: content)
            keywords.forEach { (keyword, url) in
                if let keyRange = text?.range(of: keyword) {
                    let range = NSRange(keyRange, in: keyword)
                    attributedContent.addAttribute(.foregroundColor, value: color, range: range)
                    attributedContent.addAttribute(.link, value: url, range: range)
                    attributedContent.addAttribute(.underlineColor, value: UIColor.clear, range: range)
                }
            }
            attributedText = attributedContent
        }
        textAlignment = alignment
    }

}


extension AttributedTextView: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        closure?(self, URL)
        return false
    }

}

