//
//  ErrorResponse.swift
//  Test Sahabat Mikro Fintek
//
//  Created by Devin Maleke on 19/06/24.
//

import Foundation

struct ErrorResponse:Decodable, LocalizedError{
    let reason: String
    var error: String? {return reason}
}
