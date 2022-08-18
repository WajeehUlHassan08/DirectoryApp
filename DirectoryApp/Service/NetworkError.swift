//
//  NetworkError.swift
//  DirectoryApp
//
//  Created by Wajeeh Ul Hassan on 17/08/2022.
//

import Foundation

enum NetworkError: Error {
    case urlFailure
    case dataFailure
    case serverResponse(Int)
    case decodeError(Error)
    case other(Error)
}

extension NetworkError: LocalizedError {
    
    public var errorDescription: String? {
        switch self {
        case .urlFailure:
            return NSLocalizedString("There is something wrong with the URL", comment: "URL Failure")
        case .dataFailure:
            return NSLocalizedString("There is NO Data", comment: "Data Failure")
        case .serverResponse(let statusCode):
            return NSLocalizedString("Server could not be reached, status code: \(statusCode)", comment: "Server Response Failure")
        case .decodeError:
            return NSLocalizedString("The data was fetched, but failed to serialize. Contact your failure of a developer", comment: "Decode Error")
        case .other:
            return NSLocalizedString("Unknown Error. Contact support", comment: "Other")

        }
        
        
    }
    
    
}
