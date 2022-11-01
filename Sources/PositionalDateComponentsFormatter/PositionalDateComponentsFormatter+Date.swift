import Foundation

public extension PositionalDateComponentsFormatter {
  /// Format the passed date into a positional time string.
  ///
  /// The passed calendar will be used to retrieve the `hour`, `minute`, `second`, and
  /// `nanoseconds` of the specified date. Values not returned by the calendar
  /// will be treated as `0`.
  ///
  /// - parameters:
  ///   - date: A date.
  ///   - calendar: A calendar in which the date should be evaluated.
  /// - returns: A human-readable string, such as "11:30:12.110".
  func string(from date: Date, in calendar: Calendar = .current) -> String {
    string(
      from: calendar.dateComponents(
        [.hour, .minute, .second, .nanosecond],
        from: date
      )
    )
  }
}
