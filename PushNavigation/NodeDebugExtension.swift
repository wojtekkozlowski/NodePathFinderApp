//
//  NodeDebugExtension.swift
//  Path2
//
//  Created by Wojtek Kozlowski on 28/08/2016.
//  Copyright © 2016 Wojtek Kozlowski. All rights reserved.
//

import Foundation

extension Node {
    static func printChildren(from currentNode: Node.Type = Self.self, spaces:String = "", deep: Int = 0){
        let childSeparator = (0...deep).map { _ in return " |" }.joinWithSeparator("")
        let parentSeparator = (0..<deep).map { i in
            if i < deep - 1 {
                return " |"
            } else {
                return " "
            }}.joinWithSeparator("")
        
        if currentNode.children.count == 0 {
            print("\(childSeparator)--\(currentNode.name)")
        } else {
            print("\(parentSeparator)\\-- \(currentNode.name)")
        }
        
        for child in currentNode.children {
            if child.children.count == 0 {
                printChildren(from: child, spaces: spaces + "   ", deep: deep)
            } else {
                printChildren(from: child, spaces: spaces + "   ", deep: deep + 1)
            }
        }
    }
}

