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

class FileLinesGenerator: GeneratorType {
    typealias Element = String
    
    var lines: [String]
    
    init(filename: String) {
        if let contents = String(contentsOfFile: filename, encoding: NSUTF8StringEncoding, error: nil) {
            let newLine = NSCharacterSet.newlineCharacterSet()
            lines = contents.componentsSeparatedByCharactersInSet(newLine)
        } else {
            lines = []
        }
    }
    
    func next() -> Element? {
        if let nextLine = lines.first {
            lines.removeAtIndex(0)
            return nextLine
        } else {
            return nil
        }
    }
}

func find <G: GeneratorType>(var generator:G, predicate: G.Element -> Bool) -> G.Element? {
    while let x = generator.next() {
        if predicate(x) {
            return x
        }
    }
    return nil
}

class LimitGenerator<G: GeneratorType>: GeneratorType {
    typealias Element = G.Element
    var limit = 0
    var generator: G
    
    init(limit: Int, generator: G) {
        self.limit = limit
        self.generator = generator
    }
    
    func next() -> Element? {
        if limit >= 0 {
            limit--
            return generator.next()
        } else {
            return nil
        }
    }
}

// rewrite the countdown generator
func countDown(start: Int) -> GeneratorOf<Int> {
    var i = start
    return GeneratorOf {return i < 0 ? nil : i--}
}

func +<A>(var first: GeneratorOf<A>,
    var second: GeneratorOf<A>) -> GeneratorOf<A> {
        return GeneratorOf {
            if let x = first.next() {
                return x
            } else if let x = second.next() {
                return x
            }
            return nil
        }
}

protocol SequenceType {
    typealias Generator: GeneratorType
    func generate() -> Generator
}

struct ReverseSequence<T>: SequenceType {
    var array: [T]
    init(array: [T]) {
        self.array = array
    }
    
    typealias Generator = CountdownGenerator
    func generate() -> Generator {
        return CountdownGenerator(array: array)
    }
}

let reverseSequence = ReverseSequence(array: xs)
let reverseGenerator = reverseSequence.generate()
while let i = reverseGenerator.next() {
    println("Index \(i) t is \(xs[i])")
}


func removeElement<T>(var array: [T]) -> GeneratorOf<[T]> {
    var i = 0
    return GeneratorOf {
        if i < array.count {
            var result = array
            println("\(i)")
            result.removeAtIndex(i)
            i++
            println("\(result)")
            return result
        }
        return nil
    }
}
Array(removeElement([1, 2 ,3]))

/**
*  Beyond Map and filter
*/

//struct SequenceOf<T> : SequenceType {
//    init<G: GeneratorType>(_ makeUnderlyingGenerator: () -> G)
//    func generate() -> GeneratorOf<T>
//}



