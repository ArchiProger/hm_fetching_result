import XCTest
@testable import FetchingResult

extension String: LocalizedError {
    public var errorDescription: String? { self }
}

final class UnificationResultsTests: XCTestCase {
    func testUnite() {
        let result1 = FetchingResult.success("Result")
        let result2 = FetchingResult.success(10)
        let result3 = FetchingResult.success(50.0)
        
        let result = unite(result1, result2, result3)
        
        XCTAssertEqual(result.status, .success)
        XCTAssertEqual(result.value?.0, "Result")
        XCTAssertEqual(result.value?.1, 10)
        XCTAssertEqual(result.value?.2, 50.0)
    }
    
    func testLoadingUnite() {
        let result1 = FetchingResult.success("Result")
        let result2 = FetchingResult.success(10)
        let result3 = FetchingResult<Any>.loading
        
        let result = unite(result1, result2, result3)
        
        XCTAssertEqual(result.status, .loading)
        XCTAssertNil(result.value)
    }
    
    func testFailureUnite() {
        let result1 = FetchingResult.success("Result")
        let result2 = FetchingResult.success(10)
        let result3 = FetchingResult<Any>.failure("Description")
        
        let result = unite(result1, result2, result3)
        
        XCTAssertEqual(result.status, .failure("Description"))
        XCTAssertEqual(result.error?.localizedDescription, "Description")
    }
    
    func testAllFailureUnite() {
        let result1 = FetchingResult<Double>.failure("Double failure")
        let result2 = FetchingResult<Int>.failure("Int failure")
        let result3 = FetchingResult<String>.failure("String failure")
        
        let result = unite(result1, result2, result3)
        
        XCTAssertNotEqual(result.status, .success)
        XCTAssertNotEqual(result.status, .loading)
    }
}
