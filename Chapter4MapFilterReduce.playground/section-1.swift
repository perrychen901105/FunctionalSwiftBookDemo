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
            result = combine(result , i)
        }
        return result
}

func sumUsingReduce(xs: [Int]) -> Int {
    return reduce(xs, 0) { result, x in result + x }
}

func productUsingReduce(xs: [Int]) -> Int {
    return reduce(xs, 1, *)
}

func concatUsingReduce(xs: [String]) -> String {
    return reduce(xs, "", +)
}

xs.reduce(0, combine: +)

func flatten<T>(xss: [[T]]) -> [T] {
    var result: [T] = []
    for xs in xss {
        result += xs
    }
    return result
}

let xss = [[],[2,3,4],[3,4,5]]
flatten(xss)

func flattenUsingReduce<T>(xss: [[T]]) -> [T] {
    return xss.reduce([], combine: { result , xs in result + xs })
}
flattenUsingReduce(xss)

func mapUsingReduce<T, U>(xs: [T], f: T -> U) -> [U] {
    
    return xs.reduce([], combine: { result, xs in
        return result + [f(xs)]
    })
}

var testA = mapUsingReduce(xs, { x in x * x })
println(testA)

func filterUsingReduce<T>(xs: [T], check: T -> Bool) -> [T] {
    return xs.reduce([], combine: { result ,x in
        return check(x) ? result + [x] : result
    })
}


// combine all functions
struct City {
    let name: String
    let population: Int
}

let paris = City(name: "Paris", population: 2243)
let madrid = City(name: "Madrid", population: 3216)
let amsterdam = City(name: "Amsterdam", population: 811)
let berlin = City(name: "Berlin", population: 3397)

let cities = [paris, madrid, amsterdam, berlin]

func scale(city: City) -> City {
    return City(name: city.name, population: city.population * 1000)
}

cities.filter({ city in city.population > 1000 })
    .map(scale)
    .reduce("City: Population", combine: { result, c in
        return result + "\n" + "\(c.name) : \(c.population)"
    })


func curry<A, B, C>(f: (A, B) -> C) -> A -> B -> C {
    return { x in { y in f(x, y) } }
}
func paraFunc(pa: Int, pb: Int) -> Int {
    return pa - pb
}
var cab = curry(paraFunc)
var newCab = cab(4)
println(newCab)
newCab(5)
cab(2)(3)

cab(2)(3)
println(cab)




