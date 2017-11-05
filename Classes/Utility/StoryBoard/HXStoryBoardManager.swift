//
//  HXStoryBoardManager.swift
//  HXKit-Swift
//
//  Created by ShiCang on 16/1/10.
//  Copyright © 2017年 RockerHX. All rights reserved.
//
//  GitHub: https://github.com/rockerhx
//


import UIKit


protocol HXStoryBoardProtocol {

    associatedtype Element where Element: UIViewController

    func instance() -> Self.Element
}


class HXStoryBoardManager {

    static func navigaitonControllerWithIdentifier(identifier: String, storyBoard: String = "") -> UINavigationController? {
        return self.viewController(withIdentifier: identifier, storyBoard: storyBoard) as? UINavigationController
    }
    
    static func viewController(withClass viewController: UIViewController, storyBoard: String = "") -> UIViewController {
        let identifier = String(describing: viewController)
        return self.viewController(withIdentifier: identifier, storyBoard: storyBoard)
    }
    
    static func viewController(withIdentifier identifier: String, storyBoard: String = "") -> UIViewController {
        var storyBoardFileName = storyBoard
        if storyBoard.count == 0 {
            storyBoardFileName = identifier
        }
        return UIStoryboard(name: storyBoardFileName, bundle: Bundle.main).instantiateViewController(withIdentifier: identifier)
    }
}
