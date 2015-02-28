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




