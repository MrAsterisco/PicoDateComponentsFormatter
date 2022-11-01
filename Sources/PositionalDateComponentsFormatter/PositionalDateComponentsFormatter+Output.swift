//
//  File.swift
//  
//
//  Created by Alessio Moiso on 23.10.22.
//

import Foundation

extension PositionalDateComponentsFormatter {
  func format(results: [(UnitDuration, Int)]) -> String {
    var finalResults = [(UnitDuration, Int)]()
    
    var firstValidIndex = 0
    var lastValidIndex = results.count-1
    
    if
      zeroFormattingBehavior.contains(.dropLeading) ||
        zeroFormattingBehavior.contains(.dropAll) ||
        zeroFormattingBehavior.contains(.default)
    {
      firstValidIndex = results.firstIndex(where: { $0.1 != 0 }) ?? firstValidIndex
    }
    
    if
      zeroFormattingBehavior.contains(.dropTrailing) ||
        zeroFormattingBehavior.contains(.dropAll)
    {
      lastValidIndex = results.lastIndex(where: { $0.1 != 0 }) ?? lastValidIndex
    }
    
    finalResults = Array(results[firstValidIndex...lastValidIndex])
    
    return finalResults
      .filter {
        !(zeroFormattingBehavior.contains(.dropAll) && $0.1 == 0)
      }
      .map {
        var value = (
          zeroFormattingBehavior.contains(.pad) ||
          zeroFormattingBehavior.contains(.default)
        ) ? $0.1.padded() : "\($0.1)"
        
        if $0.0 == .milliseconds {
          value = String(value.prefix(maximumDecimalValues))
        }
        
        return (
          $0.0,
          value
        )
      }
      .joined { (element: (UnitDuration, String)) in
        element.1
      } separatorProvider: {
        $0.0 == .milliseconds ? decimalUnitsSeparator : integerUnitsSeparator
      }
  }
}

extension Array {
  func joined(elementProvider: (Element) -> String, separatorProvider: (Element) -> String) -> String {
    enumerated()
      .map { (index, element) in
        var separator = ""
        if index+1 < count {
          separator = separatorProvider(self[index+1])
        }
        
        return "\(elementProvider(element))\(separator)"
      }
      .joined()
  }
}
