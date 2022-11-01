import XCTest
@testable import PositionalDateComponentsFormatter

final class DateComponentsTest: XCTestCase {
  func testFormatDefault() {
    // GIVEN
    var dateComponents = DateComponents()
    let hours = 13
    let minutes = 28
    let seconds = 17
    
    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = seconds
    
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(from: dateComponents)
    
    // THEN
    XCTAssertEqual("\(hours):\(minutes):\(seconds)", result)
  }
  
  func testFormatDefaultAllUnits() {
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
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    formatter.allowDecimalValues = true
    let result = formatter.string(from: dateComponents)
    
    // THEN
    XCTAssertEqual("\(hours):\(minutes):\(seconds).\(nanoseconds/1_000_000)", result)
  }
  
  func testFormatSomeUnits() {
    // GIVEN
    var dateComponents = DateComponents()
    let hours = 14
    let minutes = 11
    let seconds = 22
    
    dateComponents.hour = hours
    dateComponents.minute = minutes
    dateComponents.second = seconds
    
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    let result = formatter.string(from: dateComponents)
    
    // THEN
    XCTAssertEqual("\(minutes):\(seconds)", result)
  }
  
  func testMissingUnitsShouldBeZero() {
    // GIVEN
    var dateComponents = DateComponents()
    let hours = 12
    let seconds = 11
    
    dateComponents.hour = hours
    dateComponents.second = seconds
    
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(from: dateComponents)
    
    // THEN
    XCTAssertEqual("\(hours):00:\(seconds)", result)
  }
}
