//
//  AppDelegate.swift
//  PsuhNot2
//
//  Created by development on 8/29/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let tb = TabBar()
        window?.rootViewController = tb
        window?.makeKeyAndVisible()
        TabBar.printChildren()
        return true
    }
}


class TabBar: UITabBarController, Node {
    
    static let name = "t"
    static let children: [Node.Type] = [T1_R.self, T2_R.self]
    
    var selectedNavigationController: UINavigationController {
        return (self.selectedViewController as! UINavigationController)
    }
 
    override func viewDidLoad() {
        let n1 = UINavigationController()
        let t1r = T1_R()
        n1.viewControllers = [t1r]
        let n2 = UINavigationController()
        n1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.TopRated, tag: 0)
        let t2r = T2_R()
        n2.viewControllers = [t2r]
        n2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 0)
        self.viewControllers = [n1, n2]
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(remoteNotification), name: "remoteNotification", object: nil)
    }
    
    func tabIndexForNodeType(nodeType: Node.Type) -> Int? {
        let classes = self.viewControllers!.flatMap { (Mirror(reflecting:(($0 as! UINavigationController).viewControllers.first!)).subjectType as! Node.Type) }
        for (index, element) in classes.enumerate() {
            if element == nodeType {
                return index
            }
        }
        return nil
    }
    
    func selectTabForNodeType(nodeType:Node.Type){
        let newTabIndex = self.tabIndexForNodeType(nodeType)!
        self.selectedViewController = self.viewControllers![newTabIndex]
    }
    
    func pathToTargetFromVisibleNode(target:String) -> [ActionItem] {
        let visibleNode = self.selectedNavigationController.visibleNodeType
        return pathBetweenNodes(destination: target, from: visibleNode, rootNode: TabBar.self)
    }
    
    @objc func remoteNotification(notification: NSNotification) {
        let target = notification.userInfo!["target"]! as! String
       
        let visibleNodeType = self.selectedNavigationController.visibleNodeType
        let path = pathBetweenNodes(destination: target, from: visibleNodeType, rootNode: TabBar.self)
        let nodePath: [Node.Type]
        
        if let first = path.first where first.action == .Up {
            if first.node == TabBar.self {
                self.navToDifferentTab(target, path: path)
                return
            } else {
                let popTo = self.selectedNavigationController.viewControllerForNodeName(first.node.name)!
                nodePath = path.dropFirst().map { $0.node }
                let animated = nodePath.count == 0
                self.selectedNavigationController.popToViewController(popTo, animated: animated)
            }
        } else {
            nodePath = path.map { $0.node }
        }
    
        self.selectedNavigationController.visibleNode.navigateTo(nodePath)
    }
    
    func navToDifferentTab(target: String, path:[ActionItem]) {
        self.selectTabForNodeType(path[1].node)
        var newPath = pathToTargetFromVisibleNode(target)
        if let first = newPath.first where first.action == .Up {
            if newPath.count == 1 {
                let popTo = self.selectedNavigationController.viewControllerForNodeName(first.node.name)!
                self.selectedNavigationController.popToViewController(popTo, animated: true)
            } else {
                self.selectedNavigationController.popToRootViewControllerAnimated(false)
            }
            newPath = Array(newPath.dropFirst())
        }
        if newPath.count > 0 {
            let nodePath = newPath.map { $0.node }
            self.selectedNavigationController.visibleNode.navigateTo(nodePath)
        }
    }
    
    func navigateTo(path: [Node.Type]) {
        
    }
}

extension UINavigationController {
    
    var visibleNode: Node {
        return (self.visibleViewController! as! Node)
    }
    
    var visibleNodeType: Node.Type {
        return Mirror(reflecting:self.viewControllers.last!).subjectType as! Node.Type
    }
    
    func viewControllerForNodeName(nodeName: String) -> UIViewController? {
        return self.viewControllers.filter { vc in
            if let m = Mirror(reflecting: vc).subjectType as? Node.Type {
                return m.name == nodeName
            }
            return false
        }.first
    }

}

class T1_R: UIViewController, Node {
    
    static let children: [Node.Type] = [T1_R_1.self, T1_R_2.self]
    static let name = "t1_r"
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }
    
    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t1_r_1":
                let vc = T1_R_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)

            case "t1_r_2":
                let vc = T1_R_2()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)

            default: break;
            }
        }
    }
}

class T1_R_1: UIViewController, Node {
    
    static let name = "t1_r_1"
    static let children: [Node.Type] = [T1_R_1_1.self]
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }

    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t1_r_1_1":
                let vc = T1_R_1_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)

            default: break;
            }
        }
    }
}

class T1_R_1_1: UIViewController, Node {
    
    static let name = "t1_r_1_1"
    static let children: [Node.Type] = []
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }

    func navigateTo(path: [Node.Type]) {
        
    }
}

class T1_R_2: UIViewController, Node {
    
    static let name = "t1_r_2"
    static let children: [Node.Type] = [T1_R_2_1.self]
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }

    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t1_r_2_1":
                let vc = T1_R_2_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)
            default: break;
            }
        }
    }

}

class T1_R_2_1: UIViewController, Node {
    static let name = "t1_r_2_1"
    
    static let children: [Node.Type] = []
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }

    func navigateTo(path: [Node.Type]) {
        
    }
}

// -- tab 2

class T2_R: UIViewController, Node  {
    
    static let name = "t2_r"
    static let children: [Node.Type] = [T2_R_1.self, T2_R_2.self]
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }
    
    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t2_r_1":
                let vc = T2_R_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)
            case "t2_r_2":
                let vc = T2_R_2()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)

            default: break;
            }
        }
    }

}

class T2_R_1: UIViewController, Node  {
    
    static let name = "t2_r_1"
    static let children: [Node.Type] = [T2_R_1_1.self]
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }
    
    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t2_r_1_1":
                let vc = T2_R_1_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)
                
            default: break;
            }
        }
    }

    
}

class T2_R_1_1: UIViewController , Node  {
    
    static let name = "t2_r_1_1"
    static let children: [Node.Type] = []
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }

    
    func navigateTo(path: [Node.Type]) {
        
    }
    
}


class T2_R_2: UIViewController, Node  {
    
    static let name = "t2_r_2"
    static let children: [Node.Type] = [T2_R_2_1.self]
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }
    
    func navigateTo(path: [Node.Type]) {
        if let next = path.first where next.name != self.name() {
            let remainingPath = Array(path.dropFirst())
            let animated = remainingPath.count == 0
            switch next.name {
            case "t2_r_2_1":
                let vc = T2_R_2_1()
                self.navigationController?.pushViewController(vc, animated: animated)
                vc.navigateTo(remainingPath)
            default: break;
            }
        }
    }
    
}

class T2_R_2_1: UIViewController, Node {
    
    static let name = "t2_r_2_1"
    static let children: [Node.Type] = []
    
    override func viewDidLoad() {
        self.title = self.name()
        self.view.backgroundColor = UIColor.whiteColor()
        addNavRequest()
    }
    
    func navigateTo(path: [Node.Type]) {
        
    }
    
}






