//
//  Repeater.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/24/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/**
 Returns an iterator repeating a value, either infinitely or a specified number of times.
 ```
 var values = repeater(value: 0)
 // 0, 0, 0, 0, ...
 
 var values = repeater(value, 0, times: 3)
 // 0, 0, 0
 ```
 - Parameters:
    - value: The value to repeat.
    - times: The number of times to repeat. Defaults to infinite repetition.
 - Returns: An iterator repeating the value the specified number of times or infinitely otherwise.
 */
public func repeater<T>(value: T, times: Int = -1) -> Repeater<T> {
    return Repeater(value: value, times: times)
}


/// An iterator repeating a value. See `repeater(value:times:)`
public struct Repeater<T>: IteratorProtocol, LazySequenceProtocol {

    let value: T
    var times: Int

    init(value: T, times: Int) {
        self.value = value
        self.times = times
    }

    public mutating func next() -> T? {
        defer { times -= 1 }
        return times == 0 ? nil : value
    }
}
