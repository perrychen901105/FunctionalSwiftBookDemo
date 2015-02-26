// Playground - noun: a place where people can play

import UIKit

typealias Position = CGPoint
typealias Distance = CGFloat

typealias Region = Position -> Bool

let minimumDistance: Distance = 2.0

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

circle(3)(CGPoint(x: 2, y: 2))
shift(Position(x: 5, y: 5), circle(10))

func invert(region: Region) -> Region {
    return { point in !region(point) }
}

func intersection(region1: Region, region2: Region) -> Region {
    return { point in region1(point) && region2(point) }
}

func union(region1: Region, region2: Region) -> Region {
    return { point in region1(point) || region2(point) }
}

func difference(region: Region, minusRegion: Region) -> Region {
    return intersection(region, minusRegion)
}

func inRange(ownPosition: Position, target: Position, friendly: Position, range: Distance) -> Bool {
    let rangeRegion = difference(circle(range), circle(minimumDistance))
    let targetRegion = shift(ownPosition, rangeRegion)
    let friendlyRegion = shift(friendly, circle(minimumDistance))
    let resultRegion = difference(targetRegion, friendlyRegion)
    return resultRegion(target)
}

invert(circle(3))(CGPoint(x: 1, y: 1))

