//
//  NodePathFinder.swift
//  Path2
//
//  Created by Wojtek Kozlowski on 28/08/2016.
//  Copyright © 2016 Wojtek Kozlowski. All rights reserved.
//

import Foundation

protocol Node {
    static var name: String {get}
    static var children: [Node.Type] {get}
    func navigateTo(path:[Node.Type])
    static func printChildren(from currentNode: Node.Type, spaces:String, deep: Int)
}

extension Node {
    func name() -> String {
        return Self.name
    }

    func navigateTo(path:[Node.Type]) {
        
    }
}

enum Action {
    case Up, Down
}

struct ActionItem {
    let action: Action
    let node: Node.Type
}


func pathToNodeFromRoot(destination destination:String, from currentNode: Node.Type) -> [Node.Type] {
    if currentNode.name == destination {
        return [currentNode]
    } else {
        for child in currentNode.children {
            let nodesFound = pathToNodeFromRoot(destination: destination, from: child)
            if nodesFound.count > 0 {
                return [currentNode] + nodesFound
            }
        }
        return []
    }
}

func pathBetweenNodes(destination destination:String, from currentNode: Node.Type, rootNode: Node.Type) -> [ActionItem] {
    if currentNode.name == destination {
        return []
    } else {
        let pathToA = pathToNodeFromRoot(destination: destination, from: currentNode).dropFirst()
        if pathToA.count == 0 {
            let pathToAFromRoot = pathToNodeFromRoot(destination: currentNode.name, from: rootNode)
            let pathToBFromRoot = pathToNodeFromRoot(destination: destination, from: rootNode)
            return buildPath(pathToAFromRoot, arrB: pathToBFromRoot)
        } else {
            return pathToA.map { ActionItem(action: .Down, node: $0) }
        }
    }
}

func dropCommonItemsBarLast(a a:[Node.Type], b: [Node.Type]) -> ([Node.Type],[Node.Type]){
    var newA = a
    var newB = b
    
    let minI = min(a.count, b.count)
    var lastItem: Node.Type?
    
    for i in (0..<minI) {
        if a[i] == b[i] {
            lastItem = a[i]
            newA = Array(newA.dropFirst())
            newB = Array(newB.dropFirst())
        }
    }
    if let lastItem = lastItem {
        newA.insert(lastItem, atIndex: 0)
        newB.insert(lastItem, atIndex: 0)
    }
    
    return (newA, newB)}

func buildPath(arrA:[Node.Type], arrB: [Node.Type]) -> [ActionItem] {
    let (newA, newB) = dropCommonItemsBarLast(a: arrA, b: arrB)
    let resA = newA.first.map({ ActionItem(action: .Up, node: $0) })
    let resB = newB.dropFirst().map { ActionItem(action: .Down, node: $0) }
    
    if let resA = resA {
        return [resA] + resB
    } else {
        return resB
    }
}


