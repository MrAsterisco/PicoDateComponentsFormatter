# PositionalDateComponentsFormatter
The PositionalDateComponentsFormatter is a `Formatter` implementation that is able to output human-readable positional time strings from various inputs.

This implementation extends over the behavior of the [DateComponentsFormatter](https://developer.apple.com/documentation/foundation/datecomponentsformatter) *(when set to the `positional` style)* by adding support for milliseconds.

## Installation
PositionalDateComponentsFormatter is available through [Swift Package Manager](https://swift.org/package-manager).

```swift
.package(url: "https://github.com/MrAsterisco/PositionalDateComponentsFormatter", from: "<see GitHub releases>")
```

### Latest Release
To find out the latest version, look at the Releases tab of this repository. 

## Usage
PositionalDateComponentsFormatter inherits from `Formatter`, so you can invoke the generic `string(for:)` to get the formatted string.

PositionalDateComponentsFormatter can format the following input values:

- `TimeInterval`: the passed value is converted into the required units and displayed.
- `DateComponents`: valid components (`hour`, `minute`, `second`, and `nanosecond`) are displayed. Nanoseconds are converted to milliseconds.
- `Date`: the date is converted to components in the default calendar (or another one you specify) and displayed.
- `Measurement`: the passed measurement of `UnitDuration` is converted into the required units and displayed.

```swift
let formatter = PositionalDateComponentsFormatter()

// TimeInterval
let timeInterval: TimeInterval = 3665.55231354654
formatter.string(for: timeInterval) // -> 01:01:05.552

// DateComponents
var dateComponents = DateComponents()
dateComponents.hour = 13
dateComponents.minute = 28
dateComponents.second = 17
dateComponents.nanosecond = 120_345_112
formatter.string(for: dateComponents) // -> 13:28:17.120

// Date
let timeInterval = 753013811.1110001
let date = Date(timeIntervalSince1970: timeInterval)
formatter.string(for: date) // -> "11:30:11.111"

// Measurement
let measurement = Measurement(value: 120, unit: UnitDuration.milliseconds)
formatter.string(for: date) // -> "00:00:00.120"
```

You can customize the units that are displayed in the output string using the `allowedUnits` property. You can also customize the behavior of units whose value is zero by changing the `zeroFormattingBehavior` property.

## Compatibility
PositionalDateComponentsFormatter requires **iOS 13.0 or later**, **macOS 10.15 or later**, **watchOS 4.0 or later** and **tvOS 11.0 or later*.

## Contributions
All contributions to expand the library are welcome. Fork the repo, make the changes you want, and open a Pull Request.

If you make changes to the codebase, I am not enforcing a coding style, but I may ask you to make changes based on how the rest of the library is made.

## Status
This library is under **active development**. Even if most of the APIs are pretty straightforward, **they may change in the future**; but you don't have to worry about that, because releases will follow [Semantic Versioning 2.0.0](https://semver.org/).

## License
PositionalDateComponentsFormatter is distributed under the MIT license. [See LICENSE](https://github.com/MrAsterisco/PositionalDateComponentsFormatter/blob/master/LICENSE) for details.
