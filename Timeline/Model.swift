//
//  Model.swift
//  Timeline
//
//  Created by Paul Ossenbruggen on 5/23/20.
//  Copyright © 2020 Paul Ossenbruggen. All rights reserved.
//

import Foundation

private let calendar = Calendar.current
private let dateFormatter = { () -> DateFormatter in
    let df = DateFormatter()
    df.dateFormat = DateFormatter.dateFormat(
        fromTemplate: "MMMM d", options: 0, locale: .current
    )
    return df
}()

struct DateIndex {
    let date: Date
}

extension DateIndex {
    init(_ date: Date) {
        self.date = calendar.startOfDay(for: date)
    }
}

extension DateIndex: CustomDebugStringConvertible {
    var debugDescription: String {
        return dateFormatter.string(from: date)
    }
}

extension DateIndex: Comparable {
    
    static func ==(lhs: DateIndex, rhs: DateIndex) -> Bool {
        return lhs.date == rhs.date
    }
    
    static func <(lhs: DateIndex, rhs: DateIndex) -> Bool {
        return lhs.date.compare(rhs.date) == .orderedAscending
    }
}

struct Timeline<Element>: RandomAccessCollection {
    var storage: [Date: Element] = [:]
    var startIndex = DateIndex(Date.distantPast)
    var endIndex = DateIndex(Date.distantPast)

    subscript (i: DateIndex) -> Element? {
        get {
            return storage[i.date]
        }
        set {
            if isEmpty {
                startIndex = i
                endIndex = index(after: i)
            } else if i < startIndex {
                startIndex = i
            } else if i >= endIndex {
                endIndex = index(after: i)
            }
            storage[i.date] = newValue
        }
    }
    
    subscript (date: Date) -> Element? {
        get {
            return self[DateIndex(date)]
        }
        set {
            self[DateIndex(date)] = newValue
        }
    }
    
    func index(after i: DateIndex) -> DateIndex {
        let nextDay = calendar.date(byAdding: DateComponents(day: 1), to: i.date)!
        return DateIndex(nextDay)
    }
    
    func index(before i: DateIndex) -> DateIndex {
        let previousDay = calendar.date(byAdding: DateComponents(day: -1), to: i.date)!
        return DateIndex(previousDay)
    }
    
    func distance(from start: DateIndex, to end: DateIndex) -> Int {
        return calendar.dateComponents([.day], from: start.date, to: end.date).day!
    }
    
    func index(_ i: DateIndex, offsetBy n: Int) -> DateIndex {
        let offsetDate = calendar.date(byAdding: DateComponents(day: n), to: i.date)!
        return DateIndex(offsetDate)
    }
}

func ...(lhs: Date, rhs: Date) -> ClosedRange<DateIndex> {
    return DateIndex(lhs)...DateIndex(rhs)
}

func ..<(lhs: Date, rhs: Date) -> Range<DateIndex> {
    return DateIndex(lhs)..<DateIndex(rhs)
}

