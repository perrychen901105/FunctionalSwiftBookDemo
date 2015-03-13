// Playground - noun: a place where people can play

import Cocoa

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

struct Vector2D {
    var x: CGFloat
    var y: CGFloat
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
    case Align(Vector2D, Box<Diagram>)
}

enum Attribute {
    case FillColor(NSColor)
}

extension Diagram {
    var size: CGSize {
        switch self {
        case .Prim(let size, _):
            return size
        case .Attributed(_, let x):
            return x.unbox.size
        case .Beside(let l, let r):
            let sizeL = l.unbox.size
            let sizeR = l.unbox.size
            return CGSizeMake(sizeL.width + sizeR.width, max(sizeL.height, sizeR.height))
        case .Below(let l, let r):
            let sizeL = l.unbox.size
            let sizeR = r.unbox.size
            return CGSizeMake(max(sizeL.width, sizeR.width), sizeL.height+sizeR.height)
        case .Align(_, let r):
            return r.unbox.size
        }
    }
}

func fit(alignment: Vector2D,
    inputSize: CGSize, rect: CGRect) -> CGRect {
        let scaleSize = rect.size / inputSize
        let scale = min(scaleSize.width, scaleSize.height)
        let size = scale * inputSize
        let space = alignment.size * (size - rect.size)
        return CGRect(origin: rect.origin - space.point, size: size)
}

func draw(context: CGContextRef, bounds: CGRect, diagram: Diagram) {
    switch diagram {
    case .Prim(let size, .Ellipse) {
        
        }
    }
}

