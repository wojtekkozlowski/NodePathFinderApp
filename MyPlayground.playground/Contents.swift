//: Playground - noun: a place where people can play

import Cocoa

var str = "Hello, playground"

class VC {
    var presentedViewController: VC?
    init(){
        
    }
}

class NC: VC {
    
    var selectedVC: VC?
    
    func visibleVC() -> VC? {
        if let pnc = selectedVC?.presentedViewController as? NC {
            return pnc.visibleVC()
        } else {
            return selectedVC?.presentedViewController
        }
    }
}

let n1 = NC()
let v1 = VC()
n1.selectedVC = v1

let v2 = VC()
v1.presentedViewController = v2




