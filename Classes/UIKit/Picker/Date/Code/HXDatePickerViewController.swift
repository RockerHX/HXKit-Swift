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

    func datePickerView(datePicker: HXDatePickerViewController, selectedDate: Date)
}


class HXDatePickerViewController: UIViewController {

    // MARK: - IBOutlet Property -
    @IBOutlet weak var datePicker: UIDatePicker!

    // MARK: - Public Property -
    public var delegate: HXDatePickerViewControllerDelegate?
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

    // MARK: - Navigation -
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }

    // MARK: - Event Methods -
    @IBAction func dateChanged(sender: UIDatePicker) {
        delegate?.datePickerView(datePicker: self, selectedDate: sender.date)
    }

    // MARK: - Public Methods -
    // MARK: - Private Methods -
    private func configure() {
    }
}


extension HXDatePickerViewController: HXStoryBoardProtocol {

    static func instance() -> UIViewController {
        return HXStoryBoardManager.viewController(withClass: HXDatePickerViewController.self)
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

