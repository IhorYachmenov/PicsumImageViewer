//
//  Optional.swift
//  NetworkLayer
//
//  Created by user on 22.03.2023.
//

import Foundation

public extension Optional where Wrapped == String {
    func isNil() -> String {
        guard self != nil else { return "-" }
        return self!.isEmpty ? "-" : self!
    }
}

public extension Optional where Wrapped == Int {
    func isNil() -> Int {
        guard self != nil else { return 0 }
        return self!
    }
    
}
