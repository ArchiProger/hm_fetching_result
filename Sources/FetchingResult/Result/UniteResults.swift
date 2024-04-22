//
//  UniteResults.swift
//
//
//  Created by Archibbald on 11.03.2024.
//

import Foundation

public func unite<each Content>(_ content: repeat FetchingResult<each Content>) -> FetchingResult<(repeat each Content)> {
    let tuple = (repeat (each content).status)
    let mirror = Mirror(reflecting: tuple)
    
    for child in mirror.children {
        guard let result = child.value as? FetchingStatus else { continue }
        
        switch result {
            case .success:
                continue
                
            case .loading:
                return .loading
                
            case .failure(let error):
                return .failure(error)
        }
    }
    
    let result = (repeat (each content).value!)
    
    return .success(result)
}
