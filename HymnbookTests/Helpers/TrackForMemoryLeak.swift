import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(
        _ instances: AnyObject...,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        instances.forEach { instance in
            addTeardownBlock { [weak instance] in
                XCTAssertNil(
                    instance,
                    "Instance should have been deallocated. Potential memory leak.",
                    file: file,
                    line: line
                )
            }
        }
    }
}
