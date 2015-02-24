// Playground - noun: a place where people can play

import UIKit

typealias Position = CGPoint
typealias Distance = CGFloat

typealias Region = Position -> Bool

func circle(radius: Distance) -> Region {
    return { point in sqrt(point.x * point.x + point.y * point.y) <= radius}
}

func circle2(radius: Distance, center: Position) -> Region {
    return { point in
        let shiftedPoint = Position(x: point.x - center.x, y: point.y - center.y)
        return sqrt(shiftedPoint.x * shiftedPoint.x + shiftedPoint.y * shiftedPoint.y) <= radius
    }
}

func shift(offset: Position, region: Region) -> Region {
    return {
        point in
        let shiftedPoint = Position(x: point.x - offset.x, y: point.y - offset.y)
        return region(shiftedPoint)
    }
}


shift(Position(x: 5, y: 5), circle(10))
