// Playground - noun: a place where people can play

import Cocoa

protocol GeneratorType {
    typealias Element
    func next() -> Element?
}

class CountdownGenerator: GeneratorType {
    typealias Element = Int
    var element: Element
    init<T>(array: [T]) {
        self.element = array.count - 1
    }
    
    func next() -> Element? {
        return self.element < 0 ? nil : element--
    }
}

class PowerGenerator: GeneratorType {
    typealias Element = NSDecimalNumber
    
    var power: NSDecimalNumber = NSDecimalNumber(int: 1)
    let two = NSDecimalNumber(int: 2)
    
    func next() -> Element? {
        power = power.decimalNumberByMultiplyingBy(two)
        return power
    }
}

let xs = ["A", "B", "C"]

let generator = CountdownGenerator(array: xs)
while let i = generator.next() {
    println("\(i) is \(xs[i])")
}

func findPower(predicate: NSDecimalNumber -> Bool) -> NSDecimalNumber {
    let g = PowerGenerator()
    while let x = g.next() {
        if predicate(x) {
            return x
        }
    }
    return 0
}

println("\(findPower{$0.integerValue > 1000})")


