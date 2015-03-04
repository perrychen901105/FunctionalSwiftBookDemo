// Playground - noun: a place where people can play

import Cocoa

struct PointStruct {
    var x: Int
    var y: Int
}

var structPoint = PointStruct(x: 1, y: 2)
var sameStructPoint = structPoint
sameStructPoint.x = 3

println("original is \(structPoint.x), and new is \(sameStructPoint.x)")

class PointClass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
    }
}

var classPoint = PointClass(x: 1, y: 2)
var sameClassPoint = classPoint
sameClassPoint.x = 3

println("original is \(classPoint.x), and new is \(sameClassPoint.x)")

