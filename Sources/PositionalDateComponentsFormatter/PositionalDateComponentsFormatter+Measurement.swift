import Foundation

public extension PositionalDateComponentsFormatter {
  /// Format the passed measurement of duration into a positional time string.
  ///
  /// The measurement will be converted into hours, minutes, seconds, and (if enabled)
  /// milliseconds and formatted using the current options.
  ///
  /// - parameters:
  ///   - measurement: A measurement of time duration.
  /// - returns: A human-readable string, such as "11:30:12.110".
  func string(from measurement: Measurement<UnitDuration>) -> String {
    return format(
      results: convertDurationUnitValueToOtherUnits(
        durationValue: measurement.value,
        durationUnit: measurement.unit,
        allowedUnits: relevantUnitDurations
      )
    )
  }
}
