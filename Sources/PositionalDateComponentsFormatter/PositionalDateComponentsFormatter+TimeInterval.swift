//
//  File.swift
//  
//
//  Created by Alessio Moiso on 23.10.22.
//

import Foundation

public extension PositionalDateComponentsFormatter {
  /// Format the passed time interval into a positional time string.
  ///
  /// The time interval will be converted into hours, minutes, seconds, and (if enabled)
  /// milliseconds and formatted using the current options.
  ///
  /// - parameters:
  ///   - timeInterval: A time interval.
  /// - returns: A human-readable string, such as "11:30:12.110".
  func string(from timeInterval: TimeInterval) -> String {
    return format(
      results: convertDurationUnitValueToOtherUnits(
        durationValue: timeInterval,
        durationUnit: .seconds,
        allowedUnits: relevantUnitDurations
      )
    )
  }
}

// MARK: - Conversion
extension PositionalDateComponentsFormatter {
  func convert(
    measurementValue: Double,
    unitDuration: UnitDuration,
    smallestUnitDuration: UnitDuration
  ) -> (Int, Double, UnitDuration) {
    let measurementSmallest = Measurement(
      value: measurementValue,
      unit: smallestUnitDuration
    )
    
    let measurementSmallestValue = Int(
      measurementSmallest.converted(to: unitDuration).value
    )
    
    let measurementCurrentUnit = Measurement(
      value: Double(measurementSmallestValue),
      unit: unitDuration
    )
    
    let currentUnitCount = measurementCurrentUnit.converted(
      to: smallestUnitDuration
    ).value
    
    return (measurementSmallestValue, measurementValue - currentUnitCount, unitDuration)
  }
  
  func convertDurationUnitValueToOtherUnits(
    durationValue: Double,
    durationUnit: UnitDuration,
    allowedUnits: [UnitDuration]
  ) -> [(UnitDuration, Int)] {
    let smallestUnitDuration = allowedUnits.last ?? .milliseconds
    
    return sequence(
      first: (
        convert(
          measurementValue: Measurement(
            value: durationValue,
            unit: durationUnit
          ).converted(to: smallestUnitDuration).value,
          unitDuration: allowedUnits[0],
          smallestUnitDuration: smallestUnitDuration
        ),
        0
      )
    ) { [unowned self] in
      if
        allowedUnits[$0.1] == smallestUnitDuration ||
          allowedUnits.count <= $0.1 + 1
      {
        return nil
      } else {
        return (
          convert(
            measurementValue: $0.0.1,
            unitDuration: allowedUnits[$0.1 + 1],
            smallestUnitDuration: smallestUnitDuration
          ),
          $0.1 + 1
        )
      }
    }.map { element in
      (element.0.2, element.0.0)
    }
  }
}
