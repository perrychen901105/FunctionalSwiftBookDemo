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

func setStructToOrigin(var point: PointStruct) -> PointStruct {
    point.x = 0
    point.y = 0
    return point
}

var structOrigin: PointStruct = setStructToOrigin(structPoint)
println("original is \(structPoint.x), and new is \(structOrigin.x)")

func setClassToOrigin(point: PointClass) -> PointClass {
    point.x = 0
    point.y = 0
    return point
}

var classOrigin = setClassToOrigin(classPoint)
println("original is \(classPoint.x), and new is \(classOrigin.x)")

let immutablePoint = PointStruct(x: 0, y: 0)

var mutablePoint = PointStruct(x: 1, y: 1)
mutablePoint.x = 3

struct ImmutablePointStruct {
    let x: Int
    let y: Int
}

var immutablePoint2 = ImmutablePointStruct(x: 1, y: 1)









