//
//  HXPickerViewController.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/11/6.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


struct HXPickerModel {

    enum Component: Int {
        case first  = 0
        case second = 1
        case third  = 3
    }

    public var first: [String]?
    public var second: [String]?
    public var third: [String]?

    public var firstDidSelectRow: Int = 0
    public var secondDidSelectRow: Int = 0
    public var thirdDidSelectRow: Int = 0

    public func components() -> Int {
        var count = 0
        if let _ = first { count += 1 }
        if let _ = second { count += 1 }
        if let _ = third { count += 1 }
        return count
    }

    public init(first: [String]? = nil, second: [String]? = nil, third: [String]? = nil) {
        self.first = first
        self.second = second
        self.third = third
    }

}


protocol HXPickerViewControllerDelegate {

    func pickerView(controller: HXPickerViewController, didSelectRow row: Int, inComponent component: Int)

}


class HXPickerViewController: UIViewController {

    // MARK: - IBOutlet Property -
    @IBOutlet weak var pickerView: UIPickerView!

    // MARK: - Public Property -
    public var delegate: HXPickerViewControllerDelegate?
    public var tag: Any?
    public var model: HXPickerModel? {
        didSet {
            pickerView?.reloadAllComponents()
        }
    }

    // MARK: - Private Property -
    private let animation = HXModalPresentAnimation(duration: 0.3, displayHeight: 216)
    private var selected = false

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
    // MARK: - Public Methods -
    // MARK: - Private Methods -
    private func configure() {
    }

}


extension HXPickerViewController: BoardInstance {

    enum Picker: String, BoardType { case `default` = "HXPickerViewController" }

    static func instance() -> HXPickerViewController {
        return EasyBoard<Picker, HXPickerViewController>.viewController(storyBoard: .default)
    }

}


// MARK: - UIPickerViewDataSource -
extension HXPickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return model?.components() ?? 0
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let pickerComponent = HXPickerModel.Component(rawValue: component) else { return 0 }

        switch pickerComponent {
        case .first:
            return model?.first?.count ?? 0
        case .second:
            return model?.second?.count ?? 0
        case .third:
            return model?.third?.count ?? 0
        }
    }

}


// MARK: - UIPickerViewDelegate -
extension HXPickerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let pickerComponent = HXPickerModel.Component(rawValue: component) else { return "" }

        switch pickerComponent {
        case .first:
            return model?.first?[row] ?? ""
        case .second:
            return model?.second?[row] ?? ""
        case .third:
            return model?.third?[row] ?? ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selected = true
        delegate?.pickerView(controller: self, didSelectRow: row, inComponent: component)
    }

}


extension HXPickerViewController: UIViewControllerTransitioningDelegate {

    private func presentAnimation(forPresented presented: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animation
    }

    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return presentAnimation(forPresented: presented)
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if !selected {
            delegate?.pickerView(controller: self, didSelectRow: 0, inComponent: 0)
        }
        return presentAnimation(forPresented: dismissed)
    }

}

