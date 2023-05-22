import XCTest
@testable import VueFlux

final class ExecutorTests: XCTestCase {
    func testImmediateExcutor() {
        let excutor = Executor.immediate
        
        var value = 0
        
        excutor.execute { value = 1 }
        value = 2
        
        XCTAssertEqual(value, 2)
    }
    
    func testMainThreadExcutor() {
        let excutor = Executor.mainThread
        
        let expectation = self.expectation(description: "testMainThreadExcutor")
        
        DispatchQueue.globalDefault().async {
            excutor.execute {
                XCTAssertTrue(Thread.isMainThread)
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 1)
    }
    
    func testSerialMainThreadExcutor() {
        let excutor = Executor.mainThread
        
        let expectation = self.expectation(description: "testSerialMainThreadExcutor")
        
        var array = [Int]()
        
        let group = DispatchGroup()
        
        DispatchQueue.globalDefault().async(group: group) {
            excutor.execute {
                array.append(0)
            }
        }
        
        group.wait()
        
        DispatchQueue.globalDefault().async(group: group) {
            excutor.execute {
                array.append(1)
            }
            
            excutor.execute {
                array.append(2)
            }
        }
        
        group.wait()
        
        excutor.execute {
            array.append(3)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(array, [0, 1, 2, 3])
        }
    }
    
    func testDispatchQueueExcutor() {
        let excutor = Executor.queue(.globalDefault())
        
        let expectation = self.expectation(description: "testDispatchQueueExcutor")
        
        var value = 0
        
        excutor.execute {
            XCTAssertFalse(Thread.isMainThread)
            value = 1
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(value, 1)
        }
    }
}
