//
//  HXCaptchButton.swift
//
//  Created by RockerHX on 2017/4/6.
//  Copyright © 2017年 XRD.Andy. All rights reserved.
//


import UIKit


enum HXCaptchType {
    case message
    case call
}


class HXCaptchButton: HXIBButton {

    // MARK: - Public Property -
    public var captchType = HXCaptchType.message
    public var duration = 60

    // MARK: - Private Property -
    fileprivate var defaultTitle = "点击获取"
    fileprivate var defaultColor: UIColor?

    fileprivate let timer = DispatchSource.makeTimerSource()

    fileprivate var startClosure: ((HXCaptchButton) -> Bool)?
    fileprivate var endClosure: ((HXCaptchButton) -> Void)?

    // MARK: - Public Methods -
    public func timing(start: ((HXCaptchButton) -> Bool)?, end: ((HXCaptchButton) -> Void)?) {
        startClosure = start
        endClosure = end

        countDown()
    }

    public func stop() {
        timer.suspend()

        DispatchQueue.main.sync {
            setTitle(defaultTitle, for: .normal)
            isEnabled = true
            backgroundColor = defaultColor
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
        timer.cancel()
    }

    // MARK: - Configure Method -
    fileprivate func configure() {

        defaultColor = backgroundColor
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
            if let start = startClosure {
                if start(self) {
                    isEnabled = false
                    backgroundColor = UIColor.lightGray

                    var count = duration
                    timer.schedule(deadline: .now(), repeating: .seconds(1), leeway: .milliseconds(40))
                    timer.setEventHandler(handler: { [weak self] in
                        self?.down(count: count)
                        count -= 1
                    })
                    timer.resume()
                }
            }
        }
    }

    fileprivate func down(count: Int) {

        DispatchQueue.main.sync {
            setTitle("\(count)s", for: .normal)
        }

        if count == 0 {
            stop()
        }
    }
}
