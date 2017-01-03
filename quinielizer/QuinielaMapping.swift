//
//  QuinielaConvertible.swift
//  quinielizer
//
//  Created by Matias Mazzei on 1/3/17.
//  Copyright © 2017 mmazzei. All rights reserved.
//

import Foundation

enum QuinielaMappingError: Error {
    case noDescription
}

typealias QuinielaNumber = Int

protocol QuinielaMapping {
    static var meanings: [String] { get }

    func describe(_ number: QuinielaNumber) throws -> String
}

extension QuinielaMapping {

    func describe(_ number: QuinielaNumber) throws -> String {
        guard Self.meanings.indices.contains(number) else {
            throw QuinielaMappingError.noDescription
        }

        return Self.meanings[number]
    }
}
