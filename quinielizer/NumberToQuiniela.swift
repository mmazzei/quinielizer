//
//  NumberToQuiniela.swift
//  quinielizer
//
//  Created by Matias Mazzei on 1/3/17.
//  Copyright © 2017 mmazzei. All rights reserved.
//

import Foundation

enum NumberToQuinielaError: Error {
    case notANumber
}

struct NumberToQuiniela {
    private static let separator = ", "
    let mapping: QuinielaMapping

    func map(_ number: Int) throws -> String {
        return try separateInDigitPairs(number: number)
            .map { try mapping.describe($0) }
            .joined(separator: NumberToQuiniela.separator)
    }

    func map(_ number: String) throws -> String {
        // Ensure there is an even number of chars by padding with a zero
        guard number.characters.count % 2 == 0 else {
            return try map("0"+number)
        }

        return try separateInDigitPairs(string: number)
            .map { try $0.asQuinielaNumber() }
            .map { try mapping.describe($0) }
            .joined(separator: NumberToQuiniela.separator)
    }

    /// Splits the number in two digits components.
    /// ```
    /// 998877 => [99, 88, 77]
    /// 100    => [1, 0]
    /// 1020   => [10, 20]
    /// ```
    private func separateInDigitPairs(number: Int) -> [QuinielaNumber] {
        var pairs: [QuinielaNumber] = []

        var moreSignificativeDigits = number
        repeat {
            let lessSignificativeDigits = moreSignificativeDigits % 100
            pairs.insert(lessSignificativeDigits, at: 0)

            moreSignificativeDigits /= 100
        } while moreSignificativeDigits > 0

        return pairs
   }

    /// Splits the string in two chars components.
    /// ```
    /// "998877" => ["99", "88", "77"]
    /// "100"    => ["10", "0"]
    /// "1020"   => ["10", "20"]
    /// ```
    private func separateInDigitPairs(string: String) -> [String] {
        var pairs: [String] = Array(repeating: "", count: (string.characters.count + 1) / 2)

        for i in 0..<string.characters.count {
            let char = string[string.index(string.startIndex, offsetBy: i)]
            pairs[i / 2].append(char)
        }


        return pairs
    }
}

private extension String {
    func asQuinielaNumber() throws -> QuinielaNumber {
        guard let number = QuinielaNumber(self) else {
            throw NumberToQuinielaError.notANumber
        }

        return number
    }
}
