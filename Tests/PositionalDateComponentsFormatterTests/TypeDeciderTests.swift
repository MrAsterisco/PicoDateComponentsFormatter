import XCTest
@testable import PositionalDateComponentsFormatter

final class TypeDeciderTests: XCTestCase {
  func testTimeIntervalReturnsNonNilResult() {
    // GIVEN
    let timeInterval: TimeInterval = 60
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(for: timeInterval)
    
    // THEN
    XCTAssertNotNil(result)
  }
  
  func testDateComponentsReturnsNonNilResult() {
    // GIVEN
    var dateComponents = DateComponents()
    let hours = 13
    let minutes = 28
    let seconds = 17
    let nanoseconds = 120_345_112
    
    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = seconds
    dateComponents.nanosecond = nanoseconds
    
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(for: dateComponents)
    
    // THEN
    XCTAssertNotNil(result)
  }
  
  func testDateReturnsNonNilResult() {
    // GIVEN
    let timeInterval = 753013811.1110001
    let date = Date(timeIntervalSince1970: timeInterval)
    
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(for: date)
    
    // THEN
    XCTAssertNotNil(result)
  }
  
  func testMeasurementReturnsNonNilResult() {
    // GIVEN
    let measurement = Measurement(value: 25, unit: UnitDuration.minutes)
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(for: measurement)
    
    // THEN
    XCTAssertNotNil(result)
  }
  
  func testUnknownTypeReturnsNilResult() {
    // GIVEN
    let string = ""
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(for: string)
    
    // THEN
    XCTAssertNil(result)
  }
}
