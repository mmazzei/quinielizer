//
//  main.swift
//  quinielizer
//
//  Created by Matias Mazzei on 1/3/17.
//  Copyright © 2017 mmazzei. All rights reserved.
//

import Foundation

enum Mode: String {
    case sueño
    case profesión

    var mapping: QuinielaMapping {
        switch self {
        case .sueño: return Dream()
        case .profesión: return Profession()
        }
    }

}

func printWelcomeMessage() {
    print("😺 Tirá un número y dale enter...")
    print("😺 O, para cambiar de modalidad, escribí \([Mode.sueño, Mode.profesión].map { "\($0)" }.joined(separator: " o ")) y luego dale enter...")
}

func prompt() {
    print("> ", terminator: "")
}

func runMainLoop() {
    var mapper = NumberToQuiniela(mapping: Mode.sueño.mapping)
    while let line = readLine() {
        do {
            switch Mode(rawValue: line) {
            case .some(let mode):
                mapper = NumberToQuiniela(mapping: mode.mapping)

            case .none:
                print("🎲 Tu suerte: \(try mapper.map(line))")
            }
        }
        catch {
            print("⛔️ Eso no vale en la quiniela...")
        }
        prompt()
    }
}

func printGoodByeMessage() {
    print("")
    print("😺 Chau, ameo.")
}


// int main(int argc, char** argv) {
printWelcomeMessage()
prompt()
runMainLoop()
printGoodByeMessage()
// return 0
// }
