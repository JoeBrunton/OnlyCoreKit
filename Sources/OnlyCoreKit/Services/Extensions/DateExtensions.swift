//
//  DateExtensions.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 21/04/2026.
//

import Foundation

public enum DateStringFormat {
    case long
    case short
    case shortNoTime
    case noTime
    case timeOnly
}

public enum DateFormatters {
    
    private static let locale = Locale(identifier: "en_GB")
    
    public static let long: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "d MMMM yyyy 'at' HH:mm"
        return f
    }()
    
    public static let short: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "dd/MM/yyyy, HH:mm"
        return f
    }()
    
    public static let shortNoTime: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "dd/MM/yy"
        return f
    }()
    
    public static let noTime: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "dd/MM/yyyy"
        return f
    }()
    
    public static let timeOnly: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "HH:mm"
        return f
    }()
    
    public static let weekday: DateFormatter = {
        let f = DateFormatter()
        f.locale = locale
        f.dateFormat = "EEEE" // Monday
        return f
    }()
}

import Foundation

public extension Date {
    
    // MARK: - Core Formatting
    
    /// Returns a formatted string representation of the date using a predefined format.
    ///
    /// This method uses cached `DateFormatter` instances for performance and consistency.
    ///
    /// - Parameter format: The desired ``DateStringFormat``.
    /// - Returns: A formatted date string.
    ///
    /// ## Examples
    /// ```swift
    /// Date().getDateString(format: .shortNoTime)
    /// // "21/04/26"
    ///
    /// Date().getDateString(format: .long)
    /// // "21 April 2026 at 22:15"
    /// ```
    ///
    /// - Note: Uses the `en_GB` locale by default.
    func getDateString(format: DateStringFormat) -> String {
        switch format {
        case .long:
            return DateFormatters.long.string(from: self)
        case .short:
            return DateFormatters.short.string(from: self)
        case .shortNoTime:
            return DateFormatters.shortNoTime.string(from: self)
        case .noTime:
            return DateFormatters.noTime.string(from: self)
        case .timeOnly:
            return DateFormatters.timeOnly.string(from: self)
        }
    }
    
    // MARK: - Smart Display
    
    /// Returns a human-friendly, context-aware string representation of the date.
    ///
    /// This method is designed for messaging or activity feeds, adapting its output
    /// based on how recent the date is:
    ///
    /// - Today → `"Today, 14:30"`
    /// - Yesterday → `"Yesterday, 09:12"`
    /// - Within last 7 days → `"Monday, 18:45"`
    /// - Older → `"02/04/26"`
    ///
    /// - Returns: A relative, user-friendly date string.
    ///
    /// ## Example
    /// ```swift
    /// Text(message.date.smartDisplay())
    /// ```
    ///
    /// - Tip: Use this for chat bubbles, notifications, or timeline items.
    func smartDisplay() -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(self) {
            return "Today, \(timeString)"
        }
        
        if calendar.isDateInYesterday(self) {
            return "Yesterday, \(timeString)"
        }
        
        if isWithinLastWeek {
            return "\(weekdayName), \(timeString)"
        }
        
        return getDateString(format: .shortNoTime)
    }
    
    // MARK: - Section Headers
    
    /// Returns a grouping title suitable for section headers in lists or chat views.
    ///
    /// This method provides a simplified version of ``smartDisplay()``, omitting time:
    ///
    /// - Today → `"Today"`
    /// - Yesterday → `"Yesterday"`
    /// - Within last 7 days → `"Monday"`
    /// - Older → `"02/04/2026"`
    ///
    /// - Returns: A string suitable for section headers.
    ///
    /// ## Example
    /// ```swift
    /// Text(message.date.sectionHeaderTitle())
    /// ```
    ///
    /// - Tip: Ideal for grouping messages by day in a conversation UI.
    func sectionHeaderTitle() -> String {
        let calendar = Calendar.current
        
        if calendar.isDateInToday(self) { return "Today" }
        if calendar.isDateInYesterday(self) { return "Yesterday" }
        
        if isWithinLastWeek {
            return weekdayName
        }
        
        return getDateString(format: .noTime)
    }
    
    // MARK: - Convenience
    
    /// A shorthand for ``smartDisplay()``.
    ///
    /// - Returns: A context-aware formatted string.
    ///
    /// ## Example
    /// ```swift
    /// Text(date.shortDisplay)
    /// ```
    var shortDisplay: String {
        smartDisplay()
    }
    
    /// Returns the time portion of the date as a string.
    ///
    /// - Returns: A time string in `"HH:mm"` format.
    ///
    /// ## Example
    /// ```swift
    /// Date().timeString
    /// // "14:30"
    /// ```
    var timeString: String {
        getDateString(format: .timeOnly)
    }
    
    /// Returns the full weekday name for the date.
    ///
    /// - Returns: A string such as `"Monday"`.
    ///
    /// ## Example
    /// ```swift
    /// Date().weekdayName
    /// // "Tuesday"
    /// ```
    var weekdayName: String {
        DateFormatters.weekday.string(from: self)
    }
    
    // MARK: - Date Checks
    
    /// Indicates whether the date is today.
    ///
    /// - Returns: `true` if the date is within the current day.
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// Indicates whether the date is yesterday.
    ///
    /// - Returns: `true` if the date is within the previous day.
    var isYesterday: Bool {
        Calendar.current.isDateInYesterday(self)
    }
    
    /// Indicates whether the date is within the last 7 days.
    ///
    /// - Returns: `true` if the date is within the past week.
    ///
    /// - Important: This is a rolling 7-day window, not calendar week-based.
    var isWithinLastWeek: Bool {
        guard let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) else {
            return false
        }
        return self >= weekAgo
    }
}
