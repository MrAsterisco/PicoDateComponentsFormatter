import XCTest
@testable import PositionalDateComponentsFormatter

final class TimeIntervalTests: XCTestCase {
  func testFormatDefault() {
    // GIVEN
    let timeInterval: TimeInterval = 70
    let formatter = PositionalDateComponentsFormatter()
    
    // WHEN
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("01:10", result)
  }
  
  func testFormatDefaultAllUnits() {
    // GIVEN
    let timeInterval: TimeInterval = 3665.55231354654
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    formatter.allowDecimalValues = true
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("01:01:05.552", result)
  }
  
  func testFormatSomeUnits() {
    // GIVEN
    let timeInterval: TimeInterval = 3665
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.minutes, .seconds]
    
    // WHEN
    formatter.allowedUnits = units
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("61:05", result)
  }
  
  func testFormatDropLeading() {
    // GIVEN
    let timeInterval: TimeInterval = 5
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    let formattingBehavior: PositionalDateComponentsFormatter.ZeroFormattingBehavior = .dropLeading
    
    // WHEN
    formatter.allowedUnits = units
    formatter.zeroFormattingBehavior = formattingBehavior
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("5", result)
  }
  
  func testFormatDropTrailing() {
    // GIVEN
    let timeInterval: TimeInterval = 60
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    let formattingBehavior: PositionalDateComponentsFormatter.ZeroFormattingBehavior = .dropTrailing
    
    // WHEN
    formatter.allowedUnits = units
    formatter.zeroFormattingBehavior = formattingBehavior
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("0:1", result)
  }
  
  func testFormatDropAll() {
    // GIVEN
    let timeInterval: TimeInterval = 60
    let formatter = PositionalDateComponentsFormatter()
    let units: Set<PositionalDateComponentsFormatter.Unit> = [.hours, .minutes, .seconds]
    let formattingBehavior: PositionalDateComponentsFormatter.ZeroFormattingBehavior = .dropAll
    
    // WHEN
    formatter.allowedUnits = units
    formatter.zeroFormattingBehavior = formattingBehavior
    let result = formatter.string(from: timeInterval)
    
    // THEN
    XCTAssertEqual("1", result)
  }
}
