//
//  EasyBoard.swift
//  HXKit-Swift
//
//  Created by ShiCang on 16/1/10.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


protocol BoardInstance {

    associatedtype Element where Element: UIViewController

    static func instance() -> Self.Element
}


protocol BoardType: RawRepresentable {
    var name: String { get }
    var isEmpty: Bool { get }
}


extension BoardType {
    var name: String {
        get {
            return self.rawValue as! String
        }
    }
    var isEmpty: Bool {
        get {
            return (name.count == 0)
        }
    }
}


struct EasyBoard<T: BoardType> {

    static func navigaitonControllerWithIdentifier(identifier: String, storyBoard: T) -> UINavigationController? {
        return self.viewController(withIdentifier: identifier, storyBoard: storyBoard) as? UINavigationController
    }

    static func viewController(withClass viewController: UIViewController.Type, storyBoard: T ) -> UIViewController {
        let identifier = String(describing: viewController)
        return self.viewController(withIdentifier: identifier, storyBoard: storyBoard)
    }

    static func viewController(withIdentifier identifier: String, storyBoard: T) -> UIViewController {
        var name = storyBoard.name
        if storyBoard.isEmpty {
            name = identifier
        }
        return UIStoryboard(name: name, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
}
