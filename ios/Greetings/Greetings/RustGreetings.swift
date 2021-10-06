//
//  RustGreetings.swift
//  Greetings
//
//  Created by Artem Kovardin on 07.10.2021.
//

import Foundation

class RustGreetings {
    func sayHello(to: String) -> String {
        let result = rust_greeting(to)
        let swift_result = String(cString: result!)
        rust_greeting_free(UnsafeMutablePointer(mutating: result))
        return swift_result
    }
}
