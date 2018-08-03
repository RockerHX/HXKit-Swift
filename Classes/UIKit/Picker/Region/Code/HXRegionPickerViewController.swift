//
//  HXRegionPickerViewController.swift
//  HXKit-Swift
//
//  Created by RockerHX on 2017/11/6.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


protocol HXRegionPickerViewControllerDelegate {

    func pickerView(controller: HXRegionPickerViewController, selected region: (province: String, city: String?, area: String?))
    func pickerView(controller: HXRegionPickerViewController, didSelectRow row: Int, inComponent component: Int)

}


extension HXRegionPickerViewController {

    enum Style {
        case provinces
        case cities
        case areas

        var components: Int {
            switch self {
            case .provinces:
                return 1
            case .cities:
                return 2
            case .areas:
                return 3
            }
        }
    }

}


extension HXRegionPickerViewController {

    struct Selected {
        struct Row {
            struct Component {
                var first = 0
                var second = 0
                var third = 0
            }
        }
    }

}


class HXRegionPickerViewController: UIViewController {

    // MARK: - IBOutlet Property -
    @IBOutlet weak var pickerView: UIPickerView?
    @IBOutlet weak var controlContainer: UIView?
    @IBOutlet weak var titleLabel: UILabel?
    @IBOutlet weak var enterButton: UIButton?

    // MARK: - Public Property -
    public var delegate: HXRegionPickerViewControllerDelegate?
    public var style = Style.areas
    public var tinColor: UIColor?

    // MARK: - Private Property -
    private let animation = HXModalPresentAnimation(duration: 0.35)
    private var collection: HXRegion.Collection? {
        didSet {
            if nil != collection {
                pickerView?.reloadAllComponents()
            }
        }
    }
    private var selected = Selected.Row.Component()

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

    // MARK: - Configuration Methods -
    private func configure() {
        if let color = tinColor {
            enterButton?.tintColor = color
        }
        if let showTitle = title {
            titleLabel?.text = showTitle
        }
        collection = loadCollection()
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
extension HXRegionPickerViewController {

    @IBAction func backgroundTaped() {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func enterButtonTaped() {
        var province = ""
        var city: String?, area: String?
        switch style {
        case .provinces:
            province = collection?.list[safe: selected.first]?.name ?? ""
        case .cities:
            province = collection?.list[safe: selected.first]?.name ?? ""
            city = collection?.list[safe: selected.first]?.children?[safe: selected.second]?.name ?? ""
        case .areas:
            province = collection?.list[safe: selected.first]?.name ?? ""
            city = collection?.list[safe: selected.first]?.children?[safe: selected.second]?.name ?? ""
            area = collection?.list[safe: selected.first]?.children?[safe: selected.second]?.children?[safe: selected.third]?.name
        }
        delegate?.pickerView(controller: self, selected: (province, city, area))
        dismiss(animated: true, completion: nil)
    }

}


// MARK: - Public Methods -
extension HXRegionPickerViewController {
}


// MARK: - Private Methods -
extension HXRegionPickerViewController {

    private func loadCollection() -> HXRegion.Collection? {
//        guard let data = NSDataAsset(name: "Provinces&Cities")?.data else { return }
//        guard let json = (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String : [String]] else { return }
        guard let url = Bundle.main.url(forResource: "pca-code", withExtension: "json"),
              let data = try? Data(contentsOf: url)
        else { return nil }
        do {
            let list = try JSONDecoder().decode(HXRegion.Collection.self, from: data)
            return list
        } catch {
            print(error)
        }
        return nil
    }

}

extension HXRegionPickerViewController: BoardInstance {

    enum Picker: String, BoardType { case `default` = "HXRegionPickerViewController" }

    static func instance() -> HXRegionPickerViewController {
        return EasyBoard<Picker, HXRegionPickerViewController>.viewController(storyBoard: .default)
    }
}


// MARK: - UIPickerViewDataSource -
extension HXRegionPickerViewController: UIPickerViewDataSource {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return style.components
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return collection?.list.count ?? 0
        case 1:
            return collection?.list[safe: selected.first]?.children?.count ?? 0
        case 2:
            return collection?.list[safe: selected.first]?.children?[safe: selected.second]?.children?.count ?? 0
        default:
            return 0
        }
    }

}


// MARK: - UIPickerViewDelegate -
extension HXRegionPickerViewController: UIPickerViewDelegate {

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return collection?.list[safe: row]?.name ?? ""
        case 1:
            return collection?.list[safe: selected.first]?.children?[safe: row]?.name ?? ""
        case 2:
            return collection?.list[safe: selected.first]?.children?[safe: selected.second]?.children?[safe: row]?.name ?? ""
        default:
            return ""
        }
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selected.first = row
            selected.second = 0
        case 1:
            selected.second = row
        case 2:
            selected.third = row
        default:
            break
        }
        pickerView.reloadAllComponents()
        delegate?.pickerView(controller: self, didSelectRow: row, inComponent: component)
    }

}


extension HXRegionPickerViewController: UIViewControllerTransitioningDelegate {

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

