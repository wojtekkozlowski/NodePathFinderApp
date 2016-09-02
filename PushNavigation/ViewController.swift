 //
//  ViewController.swift
//  PushNavigation
//
//  Created by development on 8/31/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import UIKit

class TabBar: UITabBarController, TabBarNavigable {
    
    static let name = "<tabBar>"
    static let children: [Node.Type] = [T1_R.self, T2_R.self]
    
    override func viewDidLoad() {
        let n1 = UINavigationController()
        n1.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.TopRated, tag: 0)
        n1.viewControllers = [T1_R()]
        
        let n2 = UINavigationController()
        n2.viewControllers = [T2_R()]
        n2.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.Bookmarks, tag: 0)
        self.viewControllers = [n1, n2]
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(remoteNotification), name: "remoteNotification", object: nil)
    }
    
    @objc func remoteNotification(notification: NSNotification) {
        
        let target = (notification.userInfo!["target"]! as! String).lowercaseString
    
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC))), dispatch_get_main_queue()) {
            self.navigateToTarget(target)
        }
    }
    
}

// ---------- TAB 1 ----------

class T1_R: UIViewController, Node {
    
    static let children: [Node.Type] = [T1_R_1.self, T1_R_2.self]
    static let name = "t1_r"
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t1_r_1":
            let vc = T1_R_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
            
        case "t1_r_2":
            let vc = T1_R_2()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
    }
}

class T1_R_1: UIViewController, Node {
    
    static let name = "t1_r_1"
    static let children: [Node.Type] = [T1_R_1_1.self]
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t1_r_1_1":
            let vc = T1_R_1_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
    }
}

class T1_R_1_1: UIViewController, Node {
    
    static let name = "t1_r_1_1"
    
    override func viewDidLoad() {
        self.buildView()
    }
    
}

class T1_R_2: UIViewController, Node {
    
    static let name = "t1_r_2"
    static let children: [Node.Type] = [T1_R_2_1.self]
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t1_r_2_1":
            let vc = T1_R_2_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
    }
    
}

class T1_R_2_1: UIViewController, Node {
    static let name = "t1_r_2_1"
    
    override func viewDidLoad() {
        self.buildView()
    }
    
}

// ---------- TAB 2 ----------

class T2_R: UIViewController, Node  {
    
    static let name = "t2_r"
    static let children: [Node.Type] = [T2_R_1.self, T2_R_2.self]
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t2_r_1":
            let vc = T2_R_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        case "t2_r_2":
            let vc = T2_R_2()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
    }
    
}

class T2_R_1: UIViewController, Node  {
    
    static let name = "t2_r_1"
    static let children: [Node.Type] = [T2_R_1_1.self]
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t2_r_1_1":
            let vc = T2_R_1_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
        
    }
}

class T2_R_1_1: UIViewController, Node  {
    
    static let name = "t2_r_1_1"
    
    override func viewDidLoad() {
        self.buildView()
    }
}

class T2_R_2: UIViewController, Node  {
    
    static let name = "t2_r_2"
    static let children: [Node.Type] = [T2_R_2_1.self]
    
    override func viewDidLoad() {
        self.buildView()
    }
    
    func navigateTo(node: Node.Type, animated: Bool) -> UIViewController? {
        switch node.name {
        case "t2_r_2_1":
            let vc = T2_R_2_1()
            self.navigationController!.pushViewController(vc, animated: animated)
            return vc
        default:
            return nil
        }
    }
}

class T2_R_2_1: UIViewController, Node {
    
    static let name = "t2_r_2_1"
    
    override func viewDidLoad() {
        self.buildView()
    }
}

