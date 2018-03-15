//
//  HXSegue.swift
//  News
//
//  Created by RockerHX on 2018/3/12.
//  Copyright © 2018年 RockerHX. All rights reserved.
//

import Foundation


protocol HXSegue: RawRepresentable {

    associatedtype Element where Element: UIViewController

    var identifier: String { get }
    func performSegue(onController controller: Element, sender: Any?)
    
}

extension HXSegue {

    var identifier: String {
        get {
            return self.rawValue as! String
        }
    }

    func performSegue(onController controller: Element, sender: Any? = nil) {
        controller.performSegue(withIdentifier: self.identifier, sender: sender)
    }

}

