import XCTest
@testable import PositionalDateComponentsFormatter

class MeasurementTests: XCTestCase {
  func testFormatDefault() {
    // GIVEN
    let measurement = Measurement(value: 25, unit: UnitDuration.minutes)
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(from: measurement)
    
    // THEN
    XCTAssertEqual("25:00", result)
  }
  
  func testFormatDefaultAllUnits() {
    // GIVEN
    let measurement = Measurement(value: 120, unit: UnitDuration.milliseconds)
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    formatter.zeroFormattingBehavior = [.dropNone, .pad]
    formatter.allowDecimalValues = true
    let result = formatter.string(from: measurement)
    
    // THEN
    XCTAssertEqual("00:00:00.120", result)
  }
}
