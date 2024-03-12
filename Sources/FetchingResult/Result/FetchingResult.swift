//
//  FetchingStatus.swift
//
//
//  Created by Archibbald on 11.03.2024.
//

import Foundation

public enum FetchingResult<Result> {
    case success(Result)
    case failure(Error)
    case loading
    
    public var status: FetchingStatus {
        switch self {
            case .success(_): .success
            case .failure(let error): .failure(error)
            case .loading: .loading
        }
    }
    
    public var value: Result? {
        guard case .success(let result) = self else {
            return nil
        }

        return result
    }
    
    public var error: Error? {
        guard case .failure(let error) = self else {
            return nil
        }

        return error
    }
}
