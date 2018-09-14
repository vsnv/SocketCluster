import XCTest
@testable import SocketCluster

class SocketRocketClusterTests: XCTestCase {

    let rightConnectionStringStub = URL(string: "wss://socketclusterstub:443/socketcluster/")!
    let wrongConnectionStringStub = URL(string: "wss://FAILsocketclusterstub:443/socketcluster/")!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testInit() {
        // given
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "SocketCluster initialized successfully with URL: \(rightConnectionStringStub)")
        logger.infoExpectation = infoLogExpectation
        
        // when
        let socketRocketCluster = SocketClusterRealization(with: rightConnectionStringStub, logger: logger)
        
        // then
        XCTAssertNotNil(socketRocketCluster, "Socket Cluster init failed")
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "infoLogExpectation didn't called")
        }
        
    }
    
    func testConnectSuccess() {
        
        // given
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "SocketClusterDelegate: SocketCluster Did Connect")
        logger.infoExpectation = infoLogExpectation
        let socketRocketCluster = SocketClusterRealization.init(with: rightConnectionStringStub, logger: logger)
        let spyDelegate = MockSocketClusterDelegate()
        socketRocketCluster.delegate = spyDelegate
        let promise = expectation(description: "SocketRocketCluster calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = promise
        
        let successExpectation = expectation(description: "Connection succeeded")
        
        // when
        socketRocketCluster.connect() { isSuccess in
            if isSuccess {
                successExpectation.fulfill()
            }
        }
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testConnectFail() {
        
        // given
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "SocketClusterDelegate: SocketCluster Connection Attempt Failed")
        logger.infoExpectation = infoLogExpectation
        let socketRocketCluster = SocketClusterRealization.init(with: wrongConnectionStringStub, logger: logger)
        let spyDelegate = MockSocketClusterDelegate()
        socketRocketCluster.delegate = spyDelegate
        let promise = expectation(description: "SocketRocketCluster calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = promise
        
        let failExpectation = expectation(description: "Connection succeeded")
        
        // when
        socketRocketCluster.connect() { isSuccess in
            if isSuccess {
                
            } else {
                failExpectation.fulfill()
            }
        }
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testEmitEvent() {
        // given
        
        let eventName = "Test"
        let eventData = ["test":"test"]
        let eventCID = UUID().uuidString
        
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "Emitted event:\n cid: \(eventCID)\n name: \(eventName)\n data: \(eventData)")
        logger.infoExpectation = infoLogExpectation
        let socketCluster = SocketClusterRealization.init(with: rightConnectionStringStub, logger: logger)
        let promise = expectation(description: "Event completion called")
        
        // when
        let event: Event = EventRealisation(name: eventName, data: eventData, cid: eventCID) { (reponse) in
            promise.fulfill()
        }
        socketCluster.emit(event: event)
        
        // then
        waitForExpectations(timeout: 1, handler: nil)
        
    }

    
}
