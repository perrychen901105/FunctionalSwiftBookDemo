// Playground - noun: a place where people can play

import Cocoa

protocol Smaller {
    func smaller() -> Self?
}

protocol Arbitrary: Smaller {
    class func arbitrary() -> Self
}

//extension Int: Arbitrary {
//    static func arbitrary() -> Int {
//        return Int(arc4random())
//    }
//}
//
//println(Int.arbitrary())

extension Character: Arbitrary {
    static func arbitrary() -> Character {
        return Character(UnicodeScalar(random(from: 65, to: 90)))
    }
    
    func smaller() -> Character? { return nil }
}

func tabulate<A>(times: Int, f: Int -> A) -> [A] {
    return Array(0..<times).map(f)
}

func random(#from: Int, #to: Int) -> Int {
    return from + (Int(arc4random()) % (to - from))
}

//extension String: Arbitrary {
//    static func arbitrary() -> String {
//        let randomLength = random(from: 0, to: 40)
//        let randomCharacters = tabulate(randomLength) {
//            _ in Character.arbitrary()
//        }
//        var te = ""
//        return reduce(randomCharacters, "") {
//            $0 + String($1)
//        }
//    }
//}

//String.arbitrary()


// Check function
func check1<A: Arbitrary>(message: String, prop: A -> Bool) -> () {
    for _ in 0..<11 {
        let value = A.arbitrary()
        if !prop(value) {
            println("\"\(message)\" doesn't hold: \(value)")
            return
        }
    }
    println("\"\(message)\" passed \(11) tests.")
}

//extension CGSize: Arbitrary {
//    static func arbitrary() -> CGSize {
//        return CGSize(width: CGFloat(arc4random()), height: CGFloat(arc4random()))
//    }
//}
//
//func area(size: CGSize) -> CGFloat {
//    return size.width * size.height
//}
//
//check1("Area should be at least 0") {
//    size in area(size) >= 0
//}



extension Int: Smaller {
    func smaller() -> Int? {
        return self == 0 ? nil : self / 2
    }
}

100.smaller()

func iterateWhile<A>(condition: A -> Bool,
    initialValue: A,
    next: A -> A?) -> A {
        if let x = next(initialValue) {
            if condition(x) {
                return iterateWhile(condition, x, next)
            }
        }
        return initialValue
}

func check2<A: Arbitrary>(message: String, prop: A -> Bool) -> () {
    for _ in 0..<11 {
        let value = A.arbitrary()
        if !prop(value) {
            let smallerValue = iterateWhile({ !prop($0) }, value) {
                $0.smaller()
            }
            println("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    println("\"\(message)\" passed \(11) tests.")
}

check2("qsort should behave like sort") {
    (x: [Int]) in
    return qsort(x) == x.sorted(<)
}


// Quick sort
func qsort(var array: [Int]) -> [Int] {
    if array.isEmpty { return [] }
    let pivot = array.removeAtIndex(0)
    let lesser = array.filter { $0 < pivot }
    let greater = array.filter { $0 > pivot }
    return qsort(lesser) + [pivot] + qsort(greater)
}

struct ArbitraryI<T> {
    let arbitrary: () -> T
    let smaller: T -> T?
}

func checkHelper<A>(arbitraryInstance: ArbitraryI<A>, prop: A -> Bool, message: String) -> () {
    for _ in 0..<11 {
        let value = arbitraryInstance.arbitrary()
        if !prop(value) {
            let smallerValue = iterateWhile({ !prop($0) }, value, arbitraryInstance.smaller)
            println("\"\(message)\" doesn't hold: \(smallerValue)")
            return
        }
    }
    println("\"\(message)\" passed \(11) tests.")
}

func check<X: Arbitrary>(message: String, prop: X -> Bool) -> () {
    let instance = ArbitraryI(arbitrary: { X.arbitrary() }, smaller: { $0.smaller() })
    checkHelper(instance, prop, message)
}

func check<X: Arbitrary>(message: String, prop: [X] -> Bool) -> () {
    let instance = ArbitraryI(arbitrary: arbitraryArray, smaller: { (x: [X]) in x.smaller()})
    checkHelper(instance, prop, message)
}

