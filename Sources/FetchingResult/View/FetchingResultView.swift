//
//  FetchingResultView.swift
//
//
//  Created by Archibbald on 12.03.2024.
//

import SwiftUI

@available(iOS 13.0, macOS 10.15, watchOS 6.0, tvOS 13.0, visionOS 1.0,  *)
public struct FetchingResultView<Content, Body: View, Loading: View, Failure: View>: View {
    var result: FetchingResult<Content>
    
    @ViewBuilder var content: (Content) -> Body
    @ViewBuilder var loading: () -> Loading
    @ViewBuilder var failure: (Error) -> Failure
    
    public init(
        _ result: FetchingResult<Content>,
        content: @escaping (Content) -> Body,
        loading: @escaping () -> Loading = { EmptyView() },
        failure: @escaping (Error) -> Failure = { _ in EmptyView() }
    ) {
        self.result = result
        self.content = content
        self.loading = loading
        self.failure = failure
    }
    
    public var body: some View {
        switch result {
            case .success(let result):
                content(result)
            case .failure(let error):
                failure(error)
            case .loading:
                loading()
        }
    }
}

@available(iOS 17.0, macOS 11, watchOS 6.0, tvOS 13.0, *)
#Preview {
    FetchingResultView(.success(("Hello", "World"))) { hello, world in
        VStack {
            Text(hello)
            Text(world)
        }
    }
}
