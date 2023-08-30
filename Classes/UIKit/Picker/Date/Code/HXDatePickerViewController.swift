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


protocol HXDatePickerViewControllerDelegate: AnyObject {

    func datePickerView(_ controller: HXDatePickerViewController, selected date: Date)
    func datePickerView(_ controller: HXDatePickerViewController, comfirm date: Date)

}


class HXDatePickerViewController: ModalViewController {

    // MARK: - IBOutlet Property
    @IBOutlet weak var datePicker: UIDatePicker?
    @IBOutlet weak var controlContainer: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var enterButton: UIButton?
    @IBOutlet weak var bottomHeight: NSLayoutConstraint?

    // MARK: - Public Property
    public weak var delegate: HXDatePickerViewControllerDelegate?
    public var datePickerMode: UIDatePicker.Mode?
    public var tinColor: UIColor?
    public var tag: Any?

    // MARK: - Private Property
    private var chosedClosure: ((_ date: Date) -> Void)? = nil
    fileprivate var style: UIDatePickerStyle? = .inline

    // MARK: - View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    // MARK: - Configuration Methods
    private func configure() {
        bottomHeight?.constant = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.keyWindow?.safeAreaInsets.bottom ?? 0
        datePicker?.datePickerMode = datePickerMode ?? .dateAndTime
        datePicker?.preferredDatePickerStyle = style ?? .inline
        enterButton?.tintColor = tinColor ?? .black
        titleLabel?.text = title ?? ""
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


// MARK: - Event Methods
extension HXDatePickerViewController {

    @IBAction func backgroundTaped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func enterButtonTaped() {
        dismiss(animated: true) { [weak self] in
            guard let this = self else { return }
            guard let date = this.datePicker?.date else { return }
            this.delegate?.datePickerView(this, comfirm: date)
            self?.chosedClosure?(date)
        }
    }

    @IBAction func dateChanged(sender: UIDatePicker) {
        delegate?.datePickerView(self, selected: sender.date)
        chosedClosure?(sender.date)
    }

}

// MARK: - Public Methods -
extension HXDatePickerViewController {

    public func show(on viewController: UIViewController, style: UIDatePickerStyle? = .inline, didChosed: ((_ date: Date) -> Void)? = nil, completion: (() -> Void)? = nil) {
        self.style = style
        chosedClosure = didChosed
        viewController.present(self, animated: true, completion: completion)
    }

}


// MARK: - Private Methods
extension HXDatePickerViewController {
}


extension HXDatePickerViewController: BoardInstance {

    enum DatePicker: String, BoardType { case `default` = "HXDatePickerViewController" }

    static func instance() -> HXDatePickerViewController {
        return EasyBoard<DatePicker, HXDatePickerViewController>.viewController(storyBoard: .default)
    }

}

// MARK: - Static Methods -
extension UIViewController {

    public func showDatePicker(with title: String? = "选择日期", style: UIDatePickerStyle? = .inline, didChosed: ((_ date: Date) -> Void)? = nil, completion: (() -> Void)? = nil) {
        let datePicker = HXDatePickerViewController.instance()
        datePicker.title = title
        datePicker.show(on: self, style: style, didChosed: didChosed, completion: completion)
    }
    
}

