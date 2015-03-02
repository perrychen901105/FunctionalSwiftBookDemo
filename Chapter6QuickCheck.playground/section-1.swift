// Playground - noun: a place where people can play

import Cocoa

protocol Arbitrary {
    class func arbitrary() -> Self
}

extension Int: Arbitrary {
    static func arbitrary() -> Int {
        return Int(arc4random())
    }
}

println(Int.arbitrary())

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

extension String: Arbitrary {
    static func arbitrary() -> String {
        let randomLength = random(from: 0, to: 40)
        let randomCharacters = tabulate(randomLength) {
            _ in Character.arbitrary()
        }
        var te = ""
        return reduce(randomCharacters, "") {
            $0 + String($1)
        }
    }
}

String.arbitrary()


