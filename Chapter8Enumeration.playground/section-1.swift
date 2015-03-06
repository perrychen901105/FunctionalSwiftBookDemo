// Playground - noun: a place where people can play

import Cocoa

enum Encoding {
    case ASCII
    case NEXTSTEP
    case JapaneseEUC
    case UTF8
}

enum ReadFileResult {
    case Success(String)
    case Failure(NSError)
}

class Box<T> {
    let unbox: T
    init(_ value: T) { self.unbox = value }
}

enum Result<T> {
    case Success(Box<T>)
    case Failure(NSError)
}


func toNSStringEncoding(encoding: Encoding) -> NSStringEncoding {
    switch encoding {
    case Encoding.ASCII:
        return NSASCIIStringEncoding
    case Encoding.NEXTSTEP:
        return NSNEXTSTEPStringEncoding
    case Encoding.JapaneseEUC:
        return NSJapaneseEUCStringEncoding
    case Encoding.UTF8:
        return NSUTF8StringEncoding
    }
}

func createEncoding(enc: NSStringEncoding) -> Encoding? {
    switch enc {
    case NSASCIIStringEncoding:
        return Encoding.ASCII
    case NSNEXTSTEPStringEncoding:
        return Encoding.NEXTSTEP
    case NSJapaneseEUCStringEncoding:
        return Encoding.JapaneseEUC
    case NSUTF8StringEncoding:
        return Encoding.UTF8
    default:
        return nil
    }
}

func localizedEncodingName(encoding: Encoding) -> String {
    return String.localizedNameOfStringEncoding(toNSStringEncoding(encoding))
}

func readFile1(path: String, encoding: Encoding) -> String? {
    var maybeError: NSError? = nil
    let maybeString = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    return maybeString
}

func readFile(path: String, encoding: Encoding) -> ReadFileResult {
    var maybeError: NSError?
    let maybeString: String? = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    if let string = maybeString {
        return ReadFileResult.Success(string)
    } else if let error = maybeError {
        return ReadFileResult.Failure(error)
    } else {
        assert(false, "The impossible occurred")
    }
}

//switch readFile("/Users/wouter/fpinswift/README.md", Encoding.ASCII) {
//    case let ReadFileResult.Success(contents):
//    println("success")
//    case let ReadFileResult.Failure(error):
//    println("error")
//}


func readFileOne(path: String, encoding: Encoding) -> Result<String> {
    var maybeError: NSError?
    let maybeString: String? = NSString(contentsOfFile: path, encoding: toNSStringEncoding(encoding), error: &maybeError)
    if let string = maybeString {
        return Result.Success(Box(string))
    } else if let error = maybeError {
        return Result.Failure(error)
    } else {
        assert(false, "The impossible occurred")
    }
}

switch readFileOne("/Users/wouter/fpinswift/README.md", Encoding.ASCII) {
case let Result.Success(box):
    println("success \(box.unbox)")
case let Result.Failure(error):
    println("error")
}


//func writeFile(contents: String, path: String, encoding: Encoding) -> Result<()> {}

//func map<T, U>(f: T -> U, result: Result<T>) -> Result<U> {
//    switch result {
//    case let Result.Success(box):
//        return Result.Success(Box(f(box.unbox)))
//    case let Result.Failure(error):
//        return Result.Failure(error)
//    }
//}

