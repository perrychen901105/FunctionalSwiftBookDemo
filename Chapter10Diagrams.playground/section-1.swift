// Playground - noun: a place where people can play

import Cocoa

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum Primitive {
    case Ellipse
    case Rectangle
    case Text(String)
}

enum Diagram {
    case Prim(CGSize, Primitive)
    case Beside(Box<Diagram>, Box<Diagram>)
    case Below(Box<Diagram>, Box<Diagram>)
    case Attributed(Attribute, Box<Diagram>)
    case 
}



