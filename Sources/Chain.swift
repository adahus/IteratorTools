//
//  Chain.swift
//  IteratorTools
//
//  Created by Michael Pangburn on 8/25/17.
//  Copyright © 2017 Michael Pangburn. All rights reserved.
//

import Foundation


/**
 Returns an iterator that returns values from each sequence until all are exhausted.
 Used for treating consecutive sequences as a single sequence.
 ```
 var values = chain([1, 2, 3], [4, 5, 6])
 // 1, 2, 3, 4, 5, 6
 ```
 - Parameter sequences: The sequences to chain.
 - Returns: An iterator that returns values from each sequence until all are exhausted.
 */
public func chain<S: Sequence>(_ sequences: S...) -> Chain<S> {
    return Chain(sequences: sequences)
}


/// An iterator for chaining sequences. See `chain(_:)`.
public struct Chain<S: Sequence>: IteratorProtocol, Sequence {

    var iterators: [S.Iterator]

    init(sequences: [S]) {
        iterators = sequences.map { $0.makeIterator() }
    }

    public mutating func next() -> S.Iterator.Element? {
        guard !iterators.isEmpty else {
            return nil
        }

        guard let next = iterators[0].next() else {
            iterators = Array(iterators.dropFirst())
            return self.next()
        }

        return next
    }
}
