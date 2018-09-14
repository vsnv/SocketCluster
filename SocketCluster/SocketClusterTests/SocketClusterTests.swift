import XCTest
@testable import SocketCluster

class SocketRocketClusterTests: XCTestCase {

    let connectionStringStub = URL(string: "wss://socketclusterstub:443/socketcluster/")!

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
        let infoLogExpectation = expectation(description: "SocketCluster initialized successfully with URL: \(connectionStringStub)")
        logger.infoExpectation = infoLogExpectation
        
        // when
        let socketRocketCluster = SocketClusterRealization(with: connectionStringStub, logger: logger)
        
        // then
        XCTAssertNotNil(socketRocketCluster, "Socket Cluster init failed")
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "infoLogExpectation didn't called")
        }
        
    }
    
    func testConnect() {
        
        // given
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "SocketClusterDelegate: SocketCluster Did Connect")
        logger.infoExpectation = infoLogExpectation
        let socketRocketCluster = SocketClusterRealization.init(with: connectionStringStub, logger: logger)
        let spyDelegate = MockSocketClusterDelegate()
        socketRocketCluster.delegate = spyDelegate
        let promise = expectation(description: "SocketRocketCluster calls the delegate as the result of an async method completion")
        spyDelegate.asyncExpectation = promise
        
        // when
        socketRocketCluster.connect()
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "infoLogExpectation didn't called")
        }
        
    }
    
    func testEmitEvent() {
        // given
        let logger = MockLogger()
        let infoLogExpectation = expectation(description: "info() called")
        logger.infoExpectation = infoLogExpectation
        let socketCluster = SocketClusterRealization.init(with: connectionStringStub, logger: logger)
        let promise = expectation(description: "Event completion called")
        
        // when
        let event: Event = EventRealisation(name: "test", data: ["test":"test"], cid: UUID().uuidString) { (reponse) in
            promise.fulfill()
        }
        socketCluster.emit(event: event)
        
        // then
        waitForExpectations(timeout: 1, handler: nil)
        
    }

    
}
