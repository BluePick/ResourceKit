//
//  ExtensionsOutput.swift
//  ResourceKit
//
//  Created by Yudai.Hirose on 2017/09/23.
//  Copyright © 2017年 kingkong999yhirose. All rights reserved.
//

import Foundation

struct ExtensionsOutputImpl {
    let reusableProtocolContent: String = [
        "\(accessControl) protocol Reusable {",
        "   associatedtype View",
        "   var name: String { get }",
        "}",
    ].joined(separator: newLine)
    
    let xibProtocolContent: String = [
        "\(accessControl) protocol Xib: Reusable {",
        "\(tab1)func nib() -> UINib",
        "\(tab1)func view() -> View",
        "}",
    ].joined(separator: newLine)
    
    let tableViewExtensionContent: String = [
        "\(accessControl) extension UITableView {",
        "\(tab1)\(accessControl) func register<X: Xib>(xib: X) -> Void where X.View: UITableViewCell {",
        "\(tab2)register(xib.nib(), forCellReuseIdentifier: xib.name)",
        "\(tab1)}",
        "    ",
        "\(tab1)\(accessControl) func register<X: Xib>(xibs: [X]) -> Void where X.View: UITableViewCell {",
        "\(tab2)xibs.forEach { register(xib: $0) }",
        "\(tab1)}",
        "    ",
        "\(tab2)\(accessControl) func dequeueReusableCell<X: Reusable>(with xib: X, for indexPath: IndexPath) -> X.View where X.View: UITableViewCell {",
        "\(tab3)return dequeueReusableCell(withIdentifier: xib.name, for: indexPath) as! X.View",
        "\(tab2)}",
        "}",
        ].joined(separator: newLine)
    
    let collectionViewExtensionContent = [
        "\(accessControl) extension UICollectionView {",
        "\(tab1)\(accessControl) func register<X: Xib>(xib: X) -> Void where X.View: UICollectionViewCell {",
        "\(tab2)register(xib.nib(), forCellWithReuseIdentifier: xib.name)",
        "\(tab1)}",
        "    ",
        "\(tab1)\(accessControl) func register<X: Xib>(xibs: [X]) -> Void where X.View: UICollectionViewCell {",
        "\(tab2)xibs.forEach { register(xib: $0) }",
        "\(tab1)}",
        "    ",
        "\(tab1)\(accessControl) func dequeueReusableCell<X: Reusable>(with xib: X, for indexPath: IndexPath) -> X.View where X.View: UICollectionViewCell {",
        "\(tab2)return dequeueReusableCell(withReuseIdentifier: xib.name, for: indexPath) as! X.View",
        "\(tab1)}",
        "}",
    ].joined(separator: newLine)
}
