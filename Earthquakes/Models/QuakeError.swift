//
//  QuakeError.swift
//  Earthquakes-iOS
//
//  Created by Hussain Shareef on 2/2/25.
//  Copyright © 2025 Apple. All rights reserved.
//

import Foundation


enum QuakeError: Error {
    case missingData
    case networkError
//    case unexpectedError
    case unexpectedError(error: Error)
}

extension QuakeError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .missingData:
            return NSLocalizedString(
                "Found and will discard a quake missing a valid code, magnitude, place, or time.",
                comment: ""
            )
            
        case .networkError:
            return NSLocalizedString(
                "Network error occurred while fetching data.",
                comment: ""
            )
            
        case .unexpectedError(let error):
            return NSLocalizedString("Received unexpected error. \(error.localizedDescription)", comment: "")
            
        }
    }
}
