//
//  SyffixArrayManipulator.swift
//  DataStructuresProfiling
//
//  Created by Павел on 29.05.2020.
//  Copyright © 2020 Exey Panteleev. All rights reserved.
//

import Foundation

protocol SuffixArrayManipulator {
    func hasEntries() -> Bool
    func addObjects() -> TimeInterval
    func sort() -> TimeInterval
    func find(_ count: Int) -> (TimeInterval, Int)
}

open class SAManipulator: SuffixArrayManipulator {
    typealias SuffixAlgo = (String, String)
    fileprivate var suffixArrayManipulate = Array<SuffixAlgo>()
    fileprivate var sortedSuffixArrayManipulate = Array<SuffixAlgo>()
    fileprivate let generator = StringGenerator()
    
    func hasEntries() -> Bool {
      if (sortedSuffixArrayManipulate.count == 0) {
        return false
      } else {
        return true
      }
    }
    
    func addObjects() -> TimeInterval {
        return Profiler.runClosureForTime {
            self.suffixArrayManipulate = Array<SuffixAlgo>()
            for sort in Services.algoProvider.sortings {
                let algoName = sort.name
                self.suffixArrayManipulate.append(contentsOf: SuffixSequence(string: algoName).map { ($0, algoName) })
            }
        }
    }
    
    func sort() -> TimeInterval {
        return Profiler.runClosureForTime {
            self.sortedSuffixArrayManipulate = Array<SuffixAlgo>()
            self.sortedSuffixArrayManipulate = self.suffixArrayManipulate.sorted(by: { $0.0 < $1.0 })
        }
    }
    
    private func generateSequences(_ count: Int) -> Array<String> {
        var sequences = Array<String>()
        for _ in 0..<count {
            sequences.append(generator.generateRandomString(3))
        }
        return sequences
    }
    
    func find(_ count: Int) -> (TimeInterval, Int) {
        let sequences = generateSequences(count)
        var number = 0
        let time = Profiler.runClosureForTime {
            for seq in sequences {
                number += self.sortedSuffixArrayManipulate.filter{$0.0.contains(seq)}.count
            }
        }
        return (time, number)
    }
}
