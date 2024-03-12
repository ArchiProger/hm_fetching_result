//
//  FetchingStatus.swift
//
//
//  Created by Archibbald on 11.03.2024.
//

import Foundation

public enum FetchingStatus: Equatable {
    case success
    case failure(Error)
    case loading
    
    public static func == (lhs: FetchingStatus, rhs: FetchingStatus) -> Bool {
        switch (lhs, rhs) {
            case (.success, .success): true
            case (.loading, .loading): true
            case (.failure(let lhsError), .failure(let rhsError)): lhsError.localizedDescription == rhsError.localizedDescription
            default: false
        }
    }
    
    public var ignoringUnsuccessful: FetchingStatus {
        if case .failure(_) = self {
            return .success
        }
        
        return self
    }
}

// MARK: - Transformation of the status array
public extension [FetchingStatus] {
    var finalStatus: FetchingStatus {
        for status in self {
            switch status {
                case .success: continue
                case .failure(let error): return .failure(error)
                case .loading: return .loading
            }
        }
        
        return .success
    }
}
