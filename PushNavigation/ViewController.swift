//
//  ViewController.swift
//  PushNavigation
//
//  Created by development on 8/31/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import UIKit

class TabBar: UITabBarController, TabBarNavigable {
    
    static let name = "_"
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
        let target = notification.userInfo!["target"]! as! String
        self.navigateToTarget(target)
    }
    
    func navigateTo(path: [Node.Type]) {
        fatalError()
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

class T2_R_1_1: UIViewController, Node  {
    
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

