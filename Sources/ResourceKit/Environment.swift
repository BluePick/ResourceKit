//
//  Environment.swift
//  ResourceKit
//
//  Created by Yudai.Hirose on 2017/09/24.
//  Copyright © 2017年 kingkong999yhirose. All rights reserved.
//

import Foundation

enum Environment: String {
    case PROJECT_FILE_PATH
    case TARGET_NAME
    
    case BUILT_PRODUCTS_DIR
    case DEVELOPER_DIR
    case SDKROOT
    case SOURCE_ROOT
    case SRCROOT
    
    fileprivate static var environment: [String: String] {
        return ProcessInfo.processInfo.environment
    }
    
    var element: String {
        if debug {
            return Environment.environment["DEBUG_" + self.rawValue]!
        }
        guard let element = Environment.environment[self.rawValue] else {
            let message: String = [
                "Unexpected value for xcode environment when use Environment.element property.",
                "file: \(#file)",
                "line: \(#line)",
                "function: \(#function)",
                "rawValue: \(self.rawValue)",
                ].reduce("")
                { $0 + $1 + "\n" }
            fatalError("message: \(message) ")
        }
        return element
    }
    
    var path: URL {
        return URL(fileURLWithPath: element)
    }
    
    static func environmentWith(_ sourceTreeFolder: SourceTreeFolder) -> Environment {
        switch sourceTreeFolder {
        case .buildProductsDir:
            return BUILT_PRODUCTS_DIR
        case .developerDir:
            return DEVELOPER_DIR
        case .sdkRoot:
            return SDKROOT
        case .sourceRoot:
            return SOURCE_ROOT
        }
    }
    
    static func pathFrom(_ path: Path) -> URL {
        switch path {
        case .absolute(let absolutePath):
            return URL(fileURLWithPath: absolutePath)
        case .relativeTo(let sourceTreeFolder, let relativePath):
            return environmentWith(sourceTreeFolder)
                .path
                .appendingPathComponent(relativePath)
        }
    }
    
    fileprivate static var elements: [Environment] {
        return [PROJECT_FILE_PATH ,TARGET_NAME, BUILT_PRODUCTS_DIR ,DEVELOPER_DIR ,SDKROOT ,SOURCE_ROOT ,SRCROOT]
    }
    
    static func verifyUseEnvironment() throws {
        if let empty = elements.filter ({ Environment.environment[$0.rawValue] == nil }).first {
            throw ResourceKitErrorType.environmentError(environmentKey: empty.rawValue, errorInfo: ResourceKitErrorType.createErrorInfo())
        }
    }
    
}
