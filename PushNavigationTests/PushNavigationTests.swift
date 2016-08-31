//
//  PsuhNot2Tests.swift
//  PsuhNot2Tests
//
//  Created by development on 8/29/16.
//  Copyright © 2016 Tyro. All rights reserved.
//

import XCTest
@testable import PushNavigation

class PushNavigationUnitTests: XCTestCase {
    
    var result: [ActionItem]!
    
    func testJustGoDownTwo() {
        result = pathBetweenNodes(destination: "1_1_1_1", from: S1_1.self, rootNode: S1.self)
        XCTAssertEqual(result.count, 2)
        assertActionItem(0, action: .Down, node: S1_1_1.self)
        assertActionItem(1, action: .Down, node: S1_1_1_1.self)
    }
    
    func testJustGoDownTwoButLevelLower() {
        result = pathBetweenNodes(destination: "1_1_1_1", from: S1_1_1.self, rootNode: S1.self)
        XCTAssertEqual(result.count, 1)
        assertActionItem(0, action: .Down, node: S1_1_1_1.self)
    }
    
    func testGoToRoot() {
        result = pathBetweenNodes(destination: "1_1", from: S1_1_1_1.self, rootNode: S1.self)
        XCTAssertEqual(result.count, 1)
        assertActionItem(0, action: .Up, node: S1_1.self)
    }
    
    func testGoOneUp() {
        result = pathBetweenNodes(destination: "1_1_1", from: S1_1_1_1.self, rootNode: S1.self)
        XCTAssertEqual(result.count, 1)
        assertActionItem(0, action: .Up, node: S1_1_1.self)
    }
    
    func testCommonNearest() {
        result = pathBetweenNodes(destination: "1_1_1_3", from: S1_1_1_1.self, rootNode: S1.self)
        assertActionItem(0, action: .Up, node: S1_1_1.self)
        assertActionItem(1, action: .Down, node: S1_1_1_3.self)
    }
    
    func testCommonMiddleWay() {
        result = pathBetweenNodes(destination: "1_1_2_2", from: S1_1_1_1.self, rootNode: S1.self)
        assertActionItem(0, action: .Up, node: S1_1.self)
        assertActionItem(1, action: .Down, node: S1_1_2.self)
        assertActionItem(2, action: .Down, node: S1_1_2_2.self)
    }
    
    func testCommonOnlyRoot() {
        result = pathBetweenNodes(destination: "1_3_3_3", from: S1_1_1_1.self, rootNode: S1.self)
        assertActionItem(0, action: .Up, node: S1.self)
        assertActionItem(1, action: .Down, node: S1_3.self)
        assertActionItem(2, action: .Down, node: S1_3_3.self)
        assertActionItem(3, action: .Down, node: S1_3_3_3.self)
    }
    
    private func assertActionItem(idx: Int, action: Action, node: Node.Type){
        XCTAssertEqual(result[idx].action, action)
        XCTAssertEqual(result[idx].node.name, node.name)
    }
    
}
