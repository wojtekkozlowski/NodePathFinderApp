//
//  TabBarNavigable.swift
//  PushNot2
//
//  Created by development on 8/31/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import Foundation
import UIKit

protocol TabBarNavigable: class, Node {
    var selectedViewController: UIViewController? { get set }
    var viewControllers: [UIViewController]? { get set }
    func navigateToTarget(target: String)
}

extension TabBarNavigable {
    
    func navigateToTarget(target: String){
        let visibleNodeType = self.selectedNavigationController.visibleNodeType
        
        //todo: fix
        self.selectedNavigationController.visibleNode
        
        let path = NodePathFinder.pathBetweenNodes(destination: target, from: visibleNodeType, rootNode: TabBar.self)
        print((self.selectedViewController as! UINavigationController).visibleViewController)
        
        if let first = path.first where first.action == .Up && first.node == TabBar.self {
            self.navToDifferentTab(target, tabItem: path.dropFirst().first!.node)
        } else {
            var nodePath = path.map { $0.node }
            if let first = path.first where first.action == .Up {
                nodePath.removeFirst()
                let popTo = self.selectedNavigationController.viewControllerForNodeName(first.node.name)!
                self.selectedNavigationController.popToViewController(popTo, animated: nodePath.count == 0)
            }
            if nodePath.count > 0 {
                self.selectedNavigationController.visibleNode.navigateTo(nodePath)
            }
        }
    }
    
    private func navToDifferentTab(target: String, tabItem: Node.Type) {
        self.selectTabForNodeType(tabItem)
        var newPath = pathToTargetFromVisibleNode(target)
        if let first = newPath.first where first.action == .Up {
            newPath.removeFirst()
            if newPath.count == 0 {
                let popTo = self.selectedNavigationController.viewControllerForNodeName(first.node.name)!
                self.selectedNavigationController.popToViewController(popTo, animated: true)
            } else {
                self.selectedNavigationController.popToRootViewControllerAnimated(false)
            }
        }
        if newPath.count > 0 {
            let nodePath = newPath.map { $0.node }
            self.selectedNavigationController.visibleNode.navigateTo(nodePath)
        }
    }
    
    private func selectTabForNodeType(nodeType: Node.Type) {
        let newTabIndex = self.tabIndexForNodeType(nodeType)!
        self.selectedViewController = self.viewControllers![newTabIndex]
    }
    
    private func pathToTargetFromVisibleNode(target:String) -> [ActionItem] {
        let visibleNode = self.selectedNavigationController.visibleNodeType
        return NodePathFinder.pathBetweenNodes(destination: target, from: visibleNode, rootNode: TabBar.self)
    }
    
    private var selectedNavigationController: UINavigationController {
        return (self.selectedViewController as! UINavigationController)
    }
    
    private  func tabIndexForNodeType(nodeType: Node.Type) -> Int? {
        let classes = self.viewControllers!.flatMap { (Mirror(reflecting:(($0 as! UINavigationController).viewControllers.first!)).subjectType as! Node.Type) }
        for (index, element) in classes.enumerate() {
            if element == nodeType {
                return index
            }
        }
        return nil
    }
    
}

extension UINavigationController {
    
    var visibleNode: Node {
        for c in self.viewControllers.reverse() {
            if let visibleNode = c as? Node {
                if c.presentedViewController != nil {
                    c.dismissViewControllerAnimated(false, completion: nil)
                }
                return visibleNode
            }
        }
        fatalError()
    }
    
    var visibleNodeType: Node.Type {
        for (index, vc) in self.viewControllers.reverse().enumerate() {
            if let visibleNode = Mirror(reflecting: vc).subjectType as? Node.Type {
                 return visibleNode
            } else {
                self.viewControllers.removeAtIndex(self.viewControllers.count - 1 - index)
            }
        }
        
        fatalError()
    }
    
    
    func viewControllerForNodeName(nodeName: String) -> UIViewController? {
        return self.viewControllers.filter { vc in
            if let m = Mirror(reflecting: vc).subjectType as? Node.Type {
                return m.name == nodeName
            }
            return false
            }.first
    }
    
    func navigate(vc: UIViewController, path: [Node.Type]){
        switch path.count {
        case 1:
            self.pushViewController(vc, animated: true)
        case 0:
            break;
        default:
            self.pushViewController(vc, animated: false)
            if let node = vc as? Node {
                let remainingPath = Array(path.dropFirst())
                node.navigateTo(remainingPath)
            }
        }
    }
}


