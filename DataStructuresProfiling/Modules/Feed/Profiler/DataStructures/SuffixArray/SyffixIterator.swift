//
//  SyffixIterator.swift
//  DataStructuresProfiling
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

struct SuffixIterator: IteratorProtocol {
    let string: String
    var endOffset: String.Index
    init(string: String) {
        self.string = string
        endOffset = string.endIndex
    }
    mutating func next() -> String? {
        guard endOffset > string.startIndex else { return nil }
        endOffset = string.index(endOffset, offsetBy: -1)
        return String(string[endOffset..<string.endIndex])
    }
}

struct SuffixSequence: Sequence {
    let string: String
    func makeIterator() -> SuffixIterator {
        return SuffixIterator(string: string)
    }
}
