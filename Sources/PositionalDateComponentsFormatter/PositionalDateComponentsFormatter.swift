import Foundation

public extension PositionalDateComponentsFormatter {
  /// Formatting constants for when values contain zeroes.
  struct ZeroFormattingBehavior: OptionSet {
    /// The default formatting behavior.
    /// This option corresponds to setting `dropLeading` and `pad`.
    public static let `default` = Self(rawValue: 1 << 0)
    
    /// The drop leading zeroes formatting behavior.
    /// All units that are zero will be dropped starting from the left until one
    /// with a value higher than zero is found.
    public static let dropLeading = Self(rawValue: 1 << 1)
    
    /// The drop trailing zeroes formatting behavior.
    /// All units that are zero will be dropped starting from the right until
    /// one with a value higher than zero is found.
    public static let dropTrailing = Self(rawValue: 1 << 2)
    
    /// The drop all zeroes formatting behavior.
    /// All units whose value is zero will be dropped.
    public static let dropAll = Self(rawValue: 1 << 3)
    
    /// The drop no zeroes formatting behavior.
    /// Units whose value is zero will be kept.
    public static let dropNone = Self(rawValue: 1 << 4)
    
    /// The add padding zeroes behavior.
    /// The behavior pads values with zeroes as appropriate, with all units
    /// having at least 2 digits. For example, if the unit is `3`, it will be padded to
    /// `03`, but if the unit is `35`, it will remain as such.
    public static let pad = Self(rawValue: 1 << 5)
    
    public var rawValue: Int
    
    public init(rawValue: Int) {
      self.rawValue = rawValue
    }
  }
  
  /// Constants to represent time units.
  enum Unit: Int {
    case  hours,
          minutes,
          seconds
    
    fileprivate var unitDuration: UnitDuration {
      switch self {
      case .hours:
        return .hours
      case .minutes:
        return .minutes
      case .seconds:
        return .seconds
      }
    }
  }
}

/// A `PositionalDateComponentsFormatter` takes quantities of time and formats them
/// as human-readable strings, much like the `DateComponentsFormatter` when set to the
/// `positional` units style.
///
/// To use this class, create an instance, configure its properties, and call one of its methods to generate an appropriate string.
/// The properties of this class let you configure the time units you want displayed in the resulting string and whether additional
/// decimal values should be displayed.
///
/// The methods of this class may be called safely from any thread of your app.
/// It is also safe to share a single instance of this class from multiple threads,
/// with the caveat that you should not change the configuration of the object while another thread is using it to generate a string.
public final class PositionalDateComponentsFormatter: Formatter {
  /// Get or set the units that will be displayed in the resulting string.
  public var allowedUnits: Set<Unit> = [.hours, .minutes, .seconds]
  /// Get or set the formatting style for units whose value is 0.
  ///
  /// When the value for a particular unit is 0, the zero formatting behavior
  /// determines whether that value is retained or omitted
  /// from any resulting strings.
  ///
  /// The default value of this property is `default`.
  public var zeroFormattingBehavior: ZeroFormattingBehavior = .default
  
  /// Get or set the separator to be used between integer values (i.e. hours, minutes, and seconds).
  public var integerUnitsSeparator = ":"
  /// Get or set the separator to be used for decimal values (i.e. milliseconds).
  public var decimalUnitsSeparator = "."
  
  /// Get or set whether decimal values should be displayed.
  ///
  /// This property is used only when `seconds` is in `allowedUnits`, in all other cases
  /// it is ignored.
  public var allowDecimalValues = false
  
  /// Get or set the maximum amount of decimal values to be displayed.
  ///
  /// This property is ignored if `allowDecimalValues` is set to `false` because
  /// it only applies to milliseconds.
  public var maximumDecimalValues = 3
  
  public override func string(for obj: Any?) -> String? {
    if let timeInterval = obj as? TimeInterval {
      return string(for: timeInterval)
    } else if let dateComponents = obj as? DateComponents {
      return string(from: dateComponents)
    } else if let date = obj as? Date {
      return string(from: date)
    }
    
    return nil
  }
}

// MARK: - Output
extension Int {
  func padded() -> String {
    String(format: "%02d", self)
  }
}

// MARK: - Units
extension PositionalDateComponentsFormatter {
  var relevantUnitDurations: [UnitDuration] {
    var allowedUnits = allowedUnits
      .sorted()
      .map(\.unitDuration)
    
    if allowDecimalValues && allowedUnits.contains(.seconds) {
      allowedUnits.append(.milliseconds)
    }
    
    return allowedUnits
  }
}

extension PositionalDateComponentsFormatter.Unit: Comparable {
  public static func < (lhs: PositionalDateComponentsFormatter.Unit, rhs: PositionalDateComponentsFormatter.Unit) -> Bool {
    lhs.rawValue < rhs.rawValue
  }
}
