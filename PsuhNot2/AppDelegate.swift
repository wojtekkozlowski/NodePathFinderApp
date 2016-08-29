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
        
        return true
    }
}


class TabBar: UITabBarController, Node {
    
    static let name = "t"
    static let children: [Node.Type] = [T1_R.self, T2_R.self]
 
    override func viewDidLoad() {
        let n1 = UINavigationController()
        let t1r = T1_R()
        n1.viewControllers = [t1r]
        let n2 = UINavigationController()
        let t2r = T2_R()
        n2.viewControllers = [t2r]
        self.viewControllers = [n1, n2]
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(remoteNotification), name: "remoteNotification", object: nil)
    
    }
    
    @objc func remoteNotification(notification: NSNotification) {
        let target = notification.userInfo!["target"]! as! String
        let snc = (self.selectedViewController as! UINavigationController)
        let vvc = snc.visibleViewController!
        let m = Mirror(reflecting: vvc)
        let current = (m.subjectType as? Node.Type)!
        
        let path = pathBetweenNodes(destination: target, from: current, rootNode: TabBar.self)
        
        let nodePath: [Node.Type]
        
        if let first = path.first where first.action == .Up {
            let popTo = snc.viewControllers.filter { vc in
                let m = Mirror(reflecting: vc).subjectType as! Node.Type
                let name = m.name
                return name == first.node.name
            }.first!
            nodePath = path.dropFirst().map { $0.node }
            snc.popToViewController(popTo, animated: false)
        } else {
            nodePath = path.map { $0.node }
        }
    
        nodePath.forEach { print("\($0), ", terminator:"") }
        
        (snc.visibleViewController! as? Node)?.navigateTo(nodePath)

    }
    
    func navigateTo(path: [Node.Type]) {
        
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
            switch next.name {
            case "t1_r_1":
                let vc = T1_R_1()
                self.navigationController?.pushViewController(vc, animated: false)
                vc.navigateTo(remainingPath)

            case "t1_r_2":
                let vc = T1_R_2()
                self.navigationController?.pushViewController(vc, animated: false)
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
            switch next.name {
            case "t1_r_1_1":
                let vc = T1_R_1_1()
                self.navigationController?.pushViewController(vc, animated: false)
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
            switch next.name {
            case "t1_r_2_1":
                let vc = T1_R_2_1()
                self.navigationController?.pushViewController(vc, animated: false)
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
            switch next.name {
            case "t2_r_1":
                let vc = T2_R_1()
                self.navigationController?.pushViewController(vc, animated: false)
                vc.navigateTo(remainingPath)
            case "t2_r_2":
                let vc = T2_R_2()
                self.navigationController?.pushViewController(vc, animated: false)
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





