//
//  NodePathFinder.swift
//  Path2
//
//  Created by Wojtek Kozlowski on 28/08/2016.
//  Copyright © 2016 Wojtek Kozlowski. All rights reserved.
//

import Foundation
import UIKit

enum Action {
    case Up, Down
}

struct ActionItem {
    let action: Action
    let node: Node.Type
}

protocol Node {
    static var name: String {get}
    static var children: [Node.Type] {get}
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController?
}

struct NodePathFinder {
    static func pathBetweenNodes(destination destination:String, from currentNode: Node.Type, rootNode: Node.Type) -> [ActionItem] {
        if currentNode.name == destination {
            return []
        } else {
            let pathToA = pathToNode(destination: destination, from: currentNode).dropFirst()
            if pathToA.count == 0 {
                let pathToDestinationFromRoot = pathToNode(destination: destination, from: rootNode)
                if pathToDestinationFromRoot.count == 0 {
                    return []
                }
                let pathToCurrentFromRoot = pathToNode(destination: currentNode.name, from: rootNode)
                return buildPath(a: pathToCurrentFromRoot, b: pathToDestinationFromRoot)
            } else {
                return pathToA.map { ActionItem(action: .Down, node: $0) }
            }
        }
    }
    
    private static func pathToNode(destination destination:String, from currentNode: Node.Type) -> [Node.Type] {
        if currentNode.name == destination {
            return [currentNode]
        } else {
            for child in currentNode.children {
                let nodesFound = pathToNode(destination: destination, from: child)
                if nodesFound.count > 0 {
                    return [currentNode] + nodesFound
                }
            }
            return []
        }
    }
    
    private static func dropCommonItemsBarLast(a a:[Node.Type], b: [Node.Type]) -> ([Node.Type],[Node.Type]){
        var newA = a
        var newB = b
        
        let minI = min(a.count, b.count)
        var lastItem: Node.Type?
        
        for i in (0..<minI) {
            if a[i] == b[i] {
                lastItem = a[i]
                newA.removeFirst()
                newB.removeFirst()
            }
        }
        if let lastItem = lastItem {
            newA.insert(lastItem, atIndex: 0)
            newB.insert(lastItem, atIndex: 0)
        }
        
        return (newA, newB)}
    
    private static func buildPath(a a:[Node.Type], b: [Node.Type]) -> [ActionItem] {
        let (newA, newB) = dropCommonItemsBarLast(a: a, b: b)
        let resA = newA.first.map({ ActionItem(action: .Up, node: $0) })
        let resB = newB.dropFirst().map { ActionItem(action: .Down, node: $0) }
        
        if let resA = resA {
            return [resA] + resB
        } else {
            return resB
        }
    }
}

extension Node {
    
    static var children: [Node.Type] {
        return []
    }
    
    var name: String  {
        return Self.name
    }

    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        return nil
    }
    
}

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











