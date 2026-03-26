//
//  PrettyPrint.swift
//  OnlyCoreKit
//
//  Created by Joe Brunton on 26/03/2026.
//

import Foundation


public func prettyPrint(
    _ type: PrintType,
    _ message: Any,
    file: String = #fileID,
    function: String = #function,
    line: Int = #line
) {
    let fileName = file.components(separatedBy: "/").last ?? file
    print("\(type.rawValue) [\(fileName):\(line)] \(function) → \(message)")
}
