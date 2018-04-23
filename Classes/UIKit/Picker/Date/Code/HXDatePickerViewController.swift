//
//  HXDatePickerViewController.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/11/6.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit



protocol HXDatePickerViewControllerDelegate {

    func datePickerView(controller: HXDatePickerViewController, selected date: Date)
}


class HXDatePickerViewController: UIViewController {

    // MARK: - IBOutlet Property -
    @IBOutlet weak var datePicker: UIDatePicker!

    // MARK: - Public Property -
    public var delegate: HXDatePickerViewControllerDelegate?
    public var datePickerMode: UIDatePickerMode?
    public var tag: Any?

    // MARK: - Private Property -
    private let animation = HXModalPresentAnimation(duration: 0.3, displayHeight: 216)

    // MARK: - View Controller Life Cycle -
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        transitioningDelegate = self
        modalPresentationStyle = .custom
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }

    // MARK: - Event Methods -
    @IBAction func dateChanged(sender: UIDatePicker) {
        delegate?.datePickerView(controller: self, selected: sender.date)
    }

    // MARK: - Public Methods -
    // MARK: - Private Methods -
    private func configure() {
        delegate?.datePickerView(controller: self, selected: datePicker.date)

        if let mode = datePickerMode {
            datePicker.datePickerMode = mode
        }

        // 根据预设语言动态显示时间格式以及语言
        guard let preferredLanguage = Locale.preferredLanguages.first else { return }
        datePicker.locale = Locale(identifier: preferredLanguage)
    }
}


extension HXDatePickerViewController: BoardInstance {

    enum DatePicker: String, BoardType { case `default` = "HXDatePickerViewController" }

    static func instance() -> HXDatePickerViewController {
        return EasyBoard<DatePicker, HXDatePickerViewController>.viewController(storyBoard: .default)
    }
}


extension HXDatePickerViewController: UIViewControllerTransitioningDelegate {

    private func presentAnimation(forPresented presented: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation(forPresented: presented)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation(forPresented: dismissed)
    }
}

