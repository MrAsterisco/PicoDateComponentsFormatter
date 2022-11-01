import XCTest
@testable import PositionalDateComponentsFormatter

class DateTests: XCTestCase {
  func testFormatDefault() {
    // GIVEN
    let timeInterval: TimeInterval = 753013811
    let date = Date(timeIntervalSince1970: timeInterval)
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(from: date)
    
    // THEN
    XCTAssertEqual("11:30:11", result)
  }
  
  func testFormatDefaultAllUnits() {
    // GIVEN
    let timeInterval = 753013811.1110001
    let date = Date(timeIntervalSince1970: timeInterval)
    
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    formatter.allowDecimalValues = true
    let result = formatter.string(from: date)
    
    // THEN
    XCTAssertEqual("11:30:11.111", result)
  }
}
