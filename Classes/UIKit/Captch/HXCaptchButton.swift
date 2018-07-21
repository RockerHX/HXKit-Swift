//
//  HXCaptchButton.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/4/6.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit
import Repeat


extension HXCaptchButton {

    enum Style {
        case message
        case call
    }

}


class HXCaptchButton: UIButton {

    // MARK: - Public Property -
    @IBInspectable
    var duration: Int {
        get {
            return totalDuration;
        }
        set {
            self.totalDuration = newValue;
        }
    }
    public var style = HXCaptchButton.Style.message

    // MARK: - Private Property -
    fileprivate var totalDuration = 90
    fileprivate var defaultTitle = "点击获取"
    fileprivate var timer: Repeater?
    fileprivate var startClosure: ((HXCaptchButton) -> Void)?
    fileprivate var endClosure: ((HXCaptchButton) -> Void)?

    // MARK: - Public Methods -
    public func fir(start: ((HXCaptchButton) -> Void)? = nil, end: ((HXCaptchButton) -> Void)? = nil) {
        startClosure = start
        endClosure = end
        countDown()
    }

    public func stop() {
        timer?.pause()
        DispatchQueue.main.async {
            self.setTitle(self.defaultTitle, for: .normal)
            self.isEnabled = true
            self.endClosure?(self)
        }
    }

    // MARK: - Life Cycle -
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    deinit {
        timer?.pause()
        timer = nil
    }

    // MARK: - Configure Method -
    fileprivate func configure() {
        if let title = title(for: .normal) {
            guard title.isEmpty else {
                defaultTitle = title
                return
            }
            setTitle(defaultTitle, for: .normal)
        }
    }

    // MARK: - Private Methods -
    fileprivate func countDown() {
        if isEnabled {
            startClosure?(self)
            isEnabled = false

            var count = duration
            timer = Repeater.every(.seconds(1), queue: DispatchQueue.main, { [weak self] timer in
                self?.down(count: count)
                count -= 1
            })
        }
    }

    fileprivate func down(count: Int) {
        DispatchQueue.main.async {
            self.setTitle("\(count)s", for: .normal)
        }
        if count == 0 {
            stop()
        }
    }

}

