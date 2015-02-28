// Playground - noun: a place where people can play

import Cocoa

let cities = ["Paris": 2243, "Madrid": 3216,
            "Amsterdam": 881, "Berlin": 3397]

let madridPopulation: Int? = nil//cities["Madrid"]

if madridPopulation != nil {
    println("The population of Madrid is " +        "\(madridPopulation! * 1000)")
} else {
    println("Unknown city: Madrid")
}

if let madridPopulation = cities["Madrid"] {
    println("The population of Madrid is " + "\(madridPopulation * 1000)")
} else {
    println("Unknown city: Madrid")
}
//{ associativity left }

infix operator ?? { associativity right precedence 110 }

func ??<T>(optional: T?, defaultValue: @autoclosure () -> T) -> T {
    if let x = optional {
        return x
    } else {
        return defaultValue()
    }
}

madridPopulation ?? { return 11 }()
println(madridPopulation)

//func ??<T>(optional: T?, defaultValue: T) -> T {
//    if let x = optional {
//        return x
//    } else {
//        return defaultValue
//    }
//}
//
//func ??<T>(optional: T?, defaultValue: () -> T) -> T {
//    if let x = optional {
//        return x
//    } else {
//        return defaultValue()
//    }
//}

// Maps and more
func incrementOptional(optional: Int?) -> Int? {
    if let x = optional {
        return x + 1
    } else {
        return nil
    }
}

func map<T, U>(optional: T?, f: T -> U) -> U? {
    if let x = optional {
        return f(x)
    } else {
        return nil
    }
}

func incrementOptional2(optional: Int?) -> Int? {
    return optional.map {x in x + 1}
}

incrementOptional2(nil)

//let x: Int? = 3
//let y: Int? = nil
//let z: Int? = x + y

func addOptionals(optionalX: Int?, optionalY: Int?) -> Int? {
    if let x = optionalX {
        if let y = optionalY {
            return x + y
        }
    }
    return nil
}
var d = addOptionals(2, 3)

let capitals = ["France": "Paris", "Spain": "Madrid", "The Netherlands": "Amsterdam", "Belgium": "Brussels"]

func populationOfCapital(country: String) -> Int? {
    if let capital = capitals[country] {
        if let population = cities[capital] {
            return population * 1000
        }
    }
    return nil
}

infix operator >>= {}

func >>=<U, T>(optional: T?, f: T -> U?) -> U? {
    if let x = optional {
        return f(x)
    } else {
        return nil
    }
}

func addOptionals2(optionalX: Int?, optionalY: Int?) -> Int? {
    return optionalX >>= { x in
        optionalY >>= { y in
            x + y
        }
    }
}

func populationOfCapital2(country: String) -> Int? {
    return capitals[country] >>= { capital in
        cities[capital] >>= { population in
        return population * 1000
        }
    }
}

