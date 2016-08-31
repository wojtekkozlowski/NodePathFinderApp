//
//  Tree.swift
//  Path2
//
//  Created by Wojtek Kozlowski on 28/08/2016.
//  Copyright © 2016 Wojtek Kozlowski. All rights reserved.
//

import Foundation
@testable import PushNavigation

struct S1: Node {
    static let name = "1"
    static let children: [Node.Type] = [S1_1.self, S1_2.self, S1_3.self]
}

struct S1_1: Node  {
    static let name = "1_1"
    static let children: [Node.Type] = [S1_1_1.self,S1_1_2.self, S1_1_3.self]
}

struct S1_2: Node  {
    static let name = "1_2"
    static let children: [Node.Type] = [S1_2_1.self,S1_2_2.self, S1_2_3.self]
}

struct S1_3: Node  {
    static let name = "1_3"
    static let children: [Node.Type] = [S1_3_1.self,S1_3_2.self, S1_3_3.self]
}

struct S1_1_1: Node  {
    static let name = "1_1_1"
    static let children: [Node.Type] = [S1_1_1_1.self, S1_1_1_2.self, S1_1_1_3.self]
}

struct S1_1_1_1: Node  {
    static let name = "1_1_1_1"
    static let children: [Node.Type] = []
}

struct S1_1_1_2: Node  {
    static let name = "1_1_1_2"
    static let children: [Node.Type] = []
}

struct S1_1_1_3: Node  {
    static let name = "1_1_1_3"
    static let children: [Node.Type] = []
}

struct S1_1_2: Node  {
    static let name = "1_1_2"
    static let children: [Node.Type] = [S1_1_2_1.self, S1_1_2_2.self, S1_1_2_3.self]
}

struct S1_1_2_1: Node  {
    static let name = "1_1_2_1"
    static let children: [Node.Type] = []
}

struct S1_1_2_2: Node  {
    static let name = "1_1_2_2"
    static let children: [Node.Type] = []
}
struct S1_1_2_3: Node  {
    static let name = "1_1_2_3"
    static let children: [Node.Type] = []
}

struct S1_1_3: Node  {
    static let name = "1_1_3"
    static let children: [Node.Type] = [S1_1_3_1.self, S1_1_3_2.self, S1_1_3_3.self]
}

struct S1_1_3_1: Node  {
    static let name = "1_1_3_1"
    static let children: [Node.Type] = []
}

struct S1_1_3_2: Node  {
    static let name = "1_1_3_2"
    static let children: [Node.Type] = []
}

struct S1_1_3_3: Node  {
    static let name = "1_1_3_3"
    static let children: [Node.Type] = []
}

struct S1_2_1: Node  {
    static let name = "1_2_1"
    static let children: [Node.Type] = [S1_2_1_1.self, S1_2_1_2.self, S1_2_1_3.self]
}

struct S1_2_1_1: Node  {
    static let name = "1_2_1_1"
    static let children: [Node.Type] = []
}

struct S1_2_1_2: Node  {
    static let name = "1_2_1_2"
    static let children: [Node.Type] = []
}

struct S1_2_1_3: Node  {
    static let name = "1_2_1_3"
    static let children: [Node.Type] = []
}

struct S1_2_2: Node  {
    static let name = "1_2_2"
    static let children: [Node.Type] = [S1_2_2_1.self, S1_2_2_2.self, S1_2_2_3.self]
}

struct S1_2_2_1: Node  {
    static let name = "1_2_2_1"
    static let children: [Node.Type] = []
}

struct S1_2_2_2: Node  {
    static let name = "1_2_2_2"
    static let children: [Node.Type] = []
}

struct S1_2_2_3: Node  {
    static let name = "1_2_2_3"
    static let children: [Node.Type] = []
}

struct S1_2_3: Node  {
    static let name = "1_2_3"
    static let children: [Node.Type] = [S1_2_3_1.self, S1_2_3_2.self, S1_2_3_3.self]
}

struct S1_2_3_1: Node  {
    static let name = "1_2_3_1"
    static let children: [Node.Type] = []
}

struct S1_2_3_2: Node  {
    static let name = "1_2_3_1"
    static let children: [Node.Type] = []
}

struct S1_2_3_3: Node  {
    static let name = "1_2_3_3"
    static let children: [Node.Type] = []
}


struct S1_3_1: Node  {
    static let name = "1_3_1"
    static let children: [Node.Type] = [S1_3_1_1.self, S1_3_1_2.self, S1_3_1_3.self]
}

struct S1_3_1_1: Node  {
    static let name = "1_3_1_1"
    static let children: [Node.Type] = []
}

struct S1_3_1_2: Node  {
    static let name = "1_3_1_2"
    static let children: [Node.Type] = []
}

struct S1_3_1_3: Node  {
    static let name = "1_3_1_3"
    static let children: [Node.Type] = []
}

struct S1_3_2: Node  {
    static let name = "1_3_2"
    static let children: [Node.Type] = []
}

struct S1_3_2_1: Node  {
    static let name = "1_3_2_1"
    static let children: [Node.Type] = [S1_3_2_1.self, S1_3_2_2.self, S1_3_2_3.self]
}

struct S1_3_2_2: Node  {
    static let name = "1_3_2_2"
    static let children: [Node.Type] = []
}

struct S1_3_2_3: Node  {
    static let name = "1_3_2_3"
    static let children: [Node.Type] = []
}

struct S1_3_3: Node  {
    static let name = "1_3_3"
    static let children: [Node.Type] = [S1_3_3_1.self, S1_3_3_2.self, S1_3_3_3.self]
}

struct S1_3_3_1: Node  {
    static let name = "1_3_3_1"
    static let children: [Node.Type] = []
}

struct S1_3_3_2: Node  {
    static let name = "1_3_3_2"
    static let children: [Node.Type] = []
}

struct S1_3_3_3: Node  {
    static let name = "1_3_3_3"
    static let children: [Node.Type] = []
}








