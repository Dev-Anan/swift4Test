/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import Foundation

protocol DateFormatable {

  func string(from date: Date) -> String
  func date(from string: String) -> Date?

}

extension DateFormatter: DateFormatable {}
extension ISO8601DateFormatter: DateFormatable {}

enum Formatters {

  private static var formatters: [String: DateFormatable] = [:]

  private struct Keys {
    static let isoFormatter = "isoFormatter"
    static let shortFormatter = "shortFormatter"
  }

  static var ISODateFormatter: DateFormatable {
    if let formatter = formatters[Keys.isoFormatter] {
      return formatter
    }

    let isoformatter = ISO8601DateFormatter()
    formatters[Keys.isoFormatter] = isoformatter
    return isoformatter
  }

  static var shortDateFormatter: DateFormatable {
    if let formatter = formatters[Keys.shortFormatter] {
      return formatter
    }

    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    formatters[Keys.shortFormatter] = formatter
    return formatter
  }

}
