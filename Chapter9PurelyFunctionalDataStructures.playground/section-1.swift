// Playground - noun: a place where people can play

import Cocoa

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

func all<T> (xs : [T], predicate : T -> Bool) -> Bool {
    for x in xs {
        if !predicate(x) {
            return false
        }
    }
    return true
}

func emptySet<T>() -> Array<T> {
    return []
}

func isEmptySet<T>(set: [T]) -> Bool {
    return set.isEmpty
}

func setContains<T: Equatable>(x: T, set: [T]) -> Bool {
    return contains(set, x)
}

func setInsert<T: Equatable>(x: T, set:[T]) -> [T] {
    return setContains(x, set) ? set : [x] + set
}

enum Tree<T> {
    case Leaf
    case Node(Box<Tree<T>>, Box<T>, Box<Tree<T>>)
}

// just for test
let leaf: Tree<Int> = Tree.Leaf
let five: Tree<Int> = Tree.Node(Box(leaf), Box(5), Box(leaf))

func single<T>(x: T) -> Tree<T> {
    return Tree.Node(Box(Tree.Leaf), Box(x), Box(Tree.Leaf))
}

func count<T>(tree: Tree<T>) -> Int {
    switch tree {
    case let Tree.Leaf:
        return 0
    case let Tree.Node(left, x, right):
        return 1 + count(left.unbox) + count(right.unbox)
    }
}

func elements<T>(tree: Tree<T>) -> [T] {
    switch tree {
    case let Tree.Leaf:
        return []
    case let Tree.Node(left, x, right):
        return elements(left.unbox) + [x.unbox] + elements(right.unbox)
    }
}

func emptySet<T>() -> Tree<T> {
    return Tree.Leaf
}

func isEmptySet<T>(tree: Tree<T>) -> Bool {
    switch tree {
    case let Tree.Leaf:
        return true
    case let Tree.Node(_, _, _):
        return false
    }
}

func isBST<T: Comparable>(tree: Tree<T>) -> Bool {
    switch tree {
        case Tree.Leaf :
            return true
        case let Tree.Node(left, x, right) :
            let leftElements = elements(left.unbox)
            let rightElements = elements(right.unbox)
            return all(leftElements) { y in y < x.unbox } &&
                all(rightElements) { y in y > x.unbox } &&
                isBST(left.unbox) && isBST(right.unbox)
    }
}

func setContains<T: Comparable>(x: T, tree: Tree<T>) -> Bool {
    switch tree {
    case Tree.Leaf:
        return false
    case let Tree.Node(left, y, right) where x == y.unbox:
        return true
    case let Tree.Node(left, y, right) where x < y.unbox:
        return setContains(x, left.unbox)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return setContains(x, right.unbox)
    default:
        assert(false, "The impossible occureed")
    }
}

func setInsert<T: Comparable>(x: T, tree: Tree<T>) -> Tree<T> {
    switch tree {
    case Tree.Leaf:
        return single(x)
    case let Tree.Node(left, y, right) where x == y.unbox:
        return tree
    case let Tree.Node(left, y, right) where x < y.unbox:
        return Tree.Node(Box(setInsert(x, left.unbox)), y, right)
    case let Tree.Node(left, y, right) where x > y.unbox:
        return Tree.Node(left, y, Box(setInsert(x, right.unbox)))
    default:
        assert(false, "The impossible occureed")
    }
}

struct Trie<T: Hashable> {
    let isElem: Bool
    let children: [T: Trie<T>]
}

func empty<T: Hashable>() -> Trie<T> {
    return Trie(isElem: false, children: [T: Trie<T>]())
}

func elements<T: Hashable>(trie: Trie<T>) -> [[T]] {
    var result: [[T]] = trie.isElem ? [[]] : []
    for (key, value) in trie.children {
        result += elements(value).map( { xs in [key] + xs} )
    }
    return result
}

extension Array {
    var decompose : (head: T, tail: [T])? {
        return (count > 0) ? (self[0], Array(self[1..<count])) : nil
    }
}

func sum(xs: [Int]) -> Int {
    if let (head, tail) = xs.decompose {
        return (head + sum(tail))
    } else {
        return 0
    }
}

func qsort(var input: [Int]) -> [Int] {
    if let (pivot, rest) = input.decompose {
        let lesser = rest.filter { $0 < pivot }
        let greater = rest.filter { $0 >= pivot }
        return qsort(lesser) + [pivot] + qsort(greater)
    } else {
        return []
    }
}

func lookup<T: Hashable>(key: [T], trie: Trie<T>) -> Bool {
    if let (head, tail) = key.decompose {
        if let subtrie = trie.children[head] {
            return lookup(tail, subtrie)
        } else {
            return false
        }
    } else {
        return trie.isElem
    }
}

func withPrefix<T: Hashable>(prefix: [T], trie: Trie<T>) -> Trie<T>? {
    if let (head, tail) = prefix.decompose {
        if let remainder = trie.children[head] {
            return withPrefix(tail, remainder)
        } else {
            return nil
        }
    } else {
        return trie
    }
}

func autocomplete<T: Hashable>(key: [T], trie: Trie<T>) -> [[T]] {
    if let prefixTrie = withPrefix(key, trie) {
        return elements(prefixTrie)
    } else {
        return []
    }
}





