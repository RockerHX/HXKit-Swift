//
//  HXPathManager.swift
//  EShop
//
//  Created by ShiCang on 16/5/7.
//  Copyright © 2016年 Cave. All rights reserved.
//

import UIKit


enum HXPathDirectory {
    case Home
    case Document
    case Library
    case Caches
    case Temp

    var path: String? {
        switch self {
        case .Home:
            return NSHomeDirectory()
        case .Document:
            return self.searchPath(withDirectory: .documentDirectory)
        case .Library:
            return self.searchPath(withDirectory: .libraryDirectory)
        case .Caches:
            return self.searchPath(withDirectory: .cachesDirectory)
        case .Temp:
            return NSTemporaryDirectory()
        }
    }

    func searchPath(withDirectory directory: FileManager.SearchPathDirectory) -> String? {
        return NSSearchPathForDirectoriesInDomains(directory, .userDomainMask, true).last
    }
}


class HXPathManager: NSObject {

    // MARK: - Singleton
    static let manager = HXPathManager()

    // MARK: - Public Methods
    public func directoryPath(_ directory: HXPathDirectory) -> String? {
        return directory.path
    }

    public func store(withDirectory directory: HXPathDirectory = .Caches, relativePath: String, fileName: String) -> String? {
        if let directoryPath = directory.path {
            let path = directoryPath + relativePath

            if self.fileExists(atPath: path) {
                return path + "/" + fileName
            }
        }
        return nil
    }

    public func remove(withDirectory directory: HXPathDirectory = .Caches, relativePath: String, fileName: String) {
        if let directoryPath = directory.path {
            let path = directoryPath + relativePath + "/" + fileName

            do {
                try FileManager.default.removeItem(atPath: path)
            } catch  {}
        }
    }

    // MARK: - Private Methods
    private func fileExists(atPath path: String) -> Bool {
        let fileManager = FileManager.default

        if fileManager.fileExists(atPath: path) {
            return true
        }

        do {
            try fileManager.createDirectory(atPath: path, withIntermediateDirectories: true, attributes: nil)
        } catch {
            return false
        }
        return true
    }
}
