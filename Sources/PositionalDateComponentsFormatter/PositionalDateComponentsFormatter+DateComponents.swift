//
//  File.swift
//  
//
//  Created by Alessio Moiso on 23.10.22.
//

import Foundation

public extension PositionalDateComponentsFormatter {
  /// Format the passed date components into a positional time string.
  ///
  /// The date components will be interpreted as a definition of time, hence ignoring
  /// all components except for `hour`, `minute`, `second`, and `nanosecond`.
  /// The latter will be automatically converted to milliseconds when displayed.
  /// Missing values (i.e. values that are `nil`) will be treated as `0`.
  ///
  /// Units will not be normalized, meaning that 65 minutes will not be converted to "1:05",
  /// but they will remain `0:65`.
  ///
  /// - parameters:
  ///   - dateComponents: A `DateComponents` instance.`
  /// - returns: A human-readable string, such as "11:30:12.110".
  func string(from dateComponents: DateComponents) -> String {
    format(
      results: relevantUnitDurations
        .map {
          ($0, dateComponents.value(forUnitDuration: $0))
        }
    )
  }
}

private extension DateComponents {
  func value(forUnitDuration unitDuration: UnitDuration) -> Int {
    switch unitDuration {
    case .hours:
      return hour ?? 0
    case .minutes:
      return minute ?? 0
    case .seconds:
      return second ?? 0
    case .milliseconds:
      let measurement = Measurement(
        value: Double(nanosecond ?? 0),
        unit: UnitDuration.nanoseconds
      )
      
      return Int(
        measurement.converted(
          to: UnitDuration.milliseconds
        ).value
      )
    default:
      return 0
    }
  }
}
