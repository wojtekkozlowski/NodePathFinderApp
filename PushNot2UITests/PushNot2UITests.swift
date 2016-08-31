//
//  PushNot2UITests.swift
//  PushNot2UITests
//
//  Created by development on 8/30/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import XCTest

extension XCUIElement {
    func clearAndEnterText(text: String) -> Void {
        self.tap()
        guard let stringValue = self.value as? String else {
            XCTFail("Tried to clear and enter text into a non string value")
            return
        }
        self.tap()
        
        var deleteString: String = ""
        for _ in stringValue.characters {
            deleteString += "\u{8}"
        }
        self.typeText(deleteString)
        
        self.typeText(text)
    }
}


class PushNot2UITests: XCTestCase {
    
    private var navTextField: XCUIElement!
    private var goButton: XCUIElement!
    private var app: XCUIApplication!
    
        
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        
        navTextField = app.textFields["navTextField"]
        goButton = app.buttons["Go"]
    }
    
    func testNavigationSameTab() {
        navigateToAndAssert("t1_r_1_1")
        navigateToAndAssert("t1_r_2_1")
        navigateToAndAssert("t1_r_1")
        navigateToAndAssert("t1_r_2")
        navigateToAndAssert("t1_r")
        navigateToAndAssert("t1_r_2")
        navigateToAndAssert("t1_r")
    }
    
    func testNavigationBetweenTabs() {
        navigateToAndAssert("t1_r_1_1")
        navigateToAndAssert("t2_r_1_1")
        navigateToAndAssert("t1_r_2_1")
        navigateToAndAssert("t2_r_1_1")
        
        navigateToAndAssert("t2_r_1")
        navigateToAndAssert("t1_r_1")
        navigateToAndAssert("t2_r_2_1")
        navigateToAndAssert("t2_r")
        navigateToAndAssert("t1_r")
        navigateToAndAssert("t2_r")
    }
    
    func testThree(){
        navigateToAndAssert("t2_r_2")
        navigateToAndAssert("t2_r_1")
        navigateToAndAssert("t1_r_1_1")
        navigateToAndAssert("t2_r_1")
        navigateToAndAssert("t1_r_1")
    }
    
    func testRandom() {
        let possibleDestinations = ["t1_r", "t1_r_1", "t1_r_1_1","t1_r_2", "t1_r_2_1",  "t2_r", "t2_r_1", "t2_r_1_1","t2_r_2", "t2_r_2_1"]
        
        let destinations: [String] = (0...7600).map { _ in
            let r = Int(arc4random_uniform(UInt32(possibleDestinations.count-1)))
            return possibleDestinations[r]
        }
        for (i,d) in destinations.enumerate() {
            print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>(\(i)) going to: \(d)")
            navigateToAndAssert(d)
        }
    }
    
    private func navigateToAndAssert(destination: String) {
        navTextField.clearAndEnterText(destination)
        goButton.tap()
        XCTAssert(app.navigationBars[destination].exists)
    }
    
}
