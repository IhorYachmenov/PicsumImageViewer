//
//  Error.swift
//  NetworkLayer
//
//  Created by user on 21.03.2023.
//

import Foundation

extension NSError {
    static func error(msg: String) -> Error {
        NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: msg])
    }
}
