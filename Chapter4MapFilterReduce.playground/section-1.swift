// Playground - noun: a place where people can play

import Cocoa

// Map

func map<T, U>(xs: [T], f: T -> U) -> [U] {
    var result: [U] = []
    for x in xs {
        result.append(f(x))
    }
    return result
}

func computeIntArray<T>(xs: [Int], f: Int -> T) -> [T] {
    return map(xs, f)
}

var arr:[Int] = [1, 2, 3]
var c = computeIntArray(arr){ x in x + x }
println(c)

func doubleArray3(xs: [Int]) -> [Bool] {
    return xs.map( { x in x % 2 == 0 } )
}

doubleArray3(arr)


/**
*  Filter
*/

 /// old func
func getSwiftFiles(files: [String]) -> [String] {
    var result: [String] = []
    for file in files {
        if file.hasSuffix(".swift") {
            result.append(file)
        }
    }
    return result
}

let exampleFiles = ["README.md", "HelloWorld.swift", "HelloSwift.swift", "FlappyBird.swift"]

// new func
func filter<T>(xs: [T], check: T -> Bool) -> [T] {
    var result: [T] = []
    for x in xs {
        if check(x) {
            result.append(x)
        }
    }
    return result
}

func getSwfitFiles2(files: [String]) -> [String] {
    return filter(files) { file in file.hasSuffix(".swift") }
}

getSwiftFiles(exampleFiles)
var ca = exampleFiles.filter({ file in file.hasSuffix(".swift") })
println(ca)

/**
*  Reduce
*/

// old func
func sum(xs: [Int]) -> Int {
    var result: Int = 0
    for x in xs {
        result += x
    }
    return result
}

let xs = [1, 2, 3, 4]
sum(xs)

func reduce<A, R>(arr: [A],
    initialValue: R,
    combine: (R, A) -> R) -> R {
        var result = initialValue
        for i in arr {
            result = combine(result, i)
        }
        return result
}

func sumUsingReduce(xs: [Int]) -> Int {
    return reduce(xs, 0) { result, x in result + x }
}


