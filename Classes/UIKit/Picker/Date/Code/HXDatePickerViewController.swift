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


protocol HXDatePickerViewControllerDelegate: class {

    func datePickerView(_ controller: HXDatePickerViewController, selected date: Date)
    func datePickerView(_ controller: HXDatePickerViewController, comfirm date: Date)

}


class HXDatePickerViewController: ModalViewController {

    // MARK: - IBOutlet Property -
    @IBOutlet weak var datePicker: UIDatePicker?
    @IBOutlet weak var controlContainer: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var enterButton: UIButton?

    // MARK: - Public Property -
    public weak var delegate: HXDatePickerViewControllerDelegate?
    public var datePickerMode: UIDatePicker.Mode?
    public var tinColor: UIColor?

    // MARK: - Private Property -

    // MARK: - View Controller Life Cycle -
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Configuration Methods -
    private func configure() {
        if let mode = datePickerMode {
            datePicker?.datePickerMode = mode
        }
        if let color = tinColor {
            enterButton?.tintColor = color
        }
        if let showTitle = title {
            titleLabel?.text = showTitle
        }
        // 根据预设语言动态显示时间格式以及语言
        guard let preferredLanguage = Locale.preferredLanguages.first else { return }
        datePicker?.locale = Locale(identifier: preferredLanguage)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let radius = 8
        let rect = CGRect(origin: CGPoint.zero, size: view.bounds.size)
        let radii = CGSize(width: radius, height: radius)
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], cornerRadii: radii)
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        controlContainer?.layer.mask = maskLayer
    }

}


// MARK: - Event Methods -
extension HXDatePickerViewController {

    @IBAction func backgroundTaped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func enterButtonTaped() {
        dismiss(animated: true) { [weak self] in
            guard let this = self else { return }
            guard let date = this.datePicker?.date else { return }
            this.delegate?.datePickerView(this, comfirm: date)
        }
    }

    @IBAction func dateChanged(sender: UIDatePicker) {
        delegate?.datePickerView(self, selected: sender.date)
    }

}


// MARK: - Public Methods -
extension HXDatePickerViewController {
}


// MARK: - Private Methods -
extension HXDatePickerViewController {
}


extension HXDatePickerViewController: BoardInstance {

    enum DatePicker: String, BoardType { case `default` = "HXDatePickerViewController" }

    static func instance() -> HXDatePickerViewController {
        return EasyBoard<DatePicker, HXDatePickerViewController>.viewController(storyBoard: .default)
    }

}

