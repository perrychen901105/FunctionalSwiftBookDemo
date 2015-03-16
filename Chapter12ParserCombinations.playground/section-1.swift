// Playground - noun: a place where people can play

import Cocoa

struct Parser<Token, Result> {
    let p: Slice<Token> -> SequenceOf<(Result, Slice<Token>)>
}

func parseA() -> Parser<Character, Character> {
    let a: Character = "a"
    return Parser { x in
        if let (head, tail) = x.decompose {
            if head == a {
                return one((a, tail))
            }
        }
        return none()
    }
}





