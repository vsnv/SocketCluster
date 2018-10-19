import XCTest
@testable import SocketCluster

class SocketRocketClusterTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testConnectSuccess() {
        
        // given
        let webSocket = MockWebSocket(url: MockWebSocket.rightConnectionStringStub)
        let socketRocketCluster = SocketClusterImplementation.init(with: webSocket)
        
        let mockDelegate = MockSocketClusterDelegate()
        let didConnectExpectation = expectation(description: "SocketRocketCluster called didConnectExpectation")
        mockDelegate.didConnectExpectation = didConnectExpectation
        
        socketRocketCluster.delegate = mockDelegate

        // when
        socketRocketCluster.connect()
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testConnectFail() {
        
        // given
        let webSocket = MockWebSocket(url: MockWebSocket.wrongConnectionStringStub)
        
        let socketRocketCluster = SocketClusterImplementation.init(with: webSocket)
        
        let mockDelegate = MockSocketClusterDelegate()
        let didConnectExpectation = expectation(description: "SocketRocketCluster called didConnectExpectation")
        didConnectExpectation.isInverted = true
        mockDelegate.didConnectExpectation = didConnectExpectation
        
        socketRocketCluster.delegate = mockDelegate

        // when
        socketRocketCluster.connect()
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testDidReceivePingSuccess() {
        
        // given
        let webSocket = MockWebSocket(url: MockWebSocket.wrongConnectionStringStub)
        
        let socketRocketCluster = SocketClusterImplementation.init(with: webSocket)
        
        let mockDelegate = MockSocketClusterDelegate()
        let didReceivePingExpectation = expectation(description: "SocketCluster called didReceivePing")
        mockDelegate.didReceivePingExpectation = didReceivePingExpectation
        
        socketRocketCluster.delegate = mockDelegate
        
         socketRocketCluster.connect()

        // when
        webSocket.sendPing()
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testDidReceivePingFail() {
        
        // given
        let webSocket = MockWebSocket(url: MockWebSocket.wrongConnectionStringStub)
        
        let socketRocketCluster = SocketClusterImplementation.init(with: webSocket)
        
        let mockDelegate = MockSocketClusterDelegate()
        let didReceivePingExpectation = expectation(description: "SocketCluster called didReceivePing")
        didReceivePingExpectation.isInverted = true
        mockDelegate.didReceivePingExpectation = didReceivePingExpectation
        
        socketRocketCluster.delegate = mockDelegate
        
        socketRocketCluster.connect()
        
        // when
//        webSocket.sendPing()
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
        
    }
    
    func testSendHandshakeAfterDidConnectSuccess() {
        // given
        let webSocket = MockWebSocket(url: MockWebSocket.rightConnectionStringStub)
        let socketCluster = SocketClusterImplementation.init(with: webSocket)
        
        let mockDelegate = MockSocketClusterDelegate()
        let didConnectExpectation = expectation(description: "SocketRocketCluster called didConnectExpectation")
        mockDelegate.didConnectExpectation = didConnectExpectation
        
        socketCluster.delegate = mockDelegate
        
        // when
        mockDelegate.socketClusterDidConnect(socketCluster)
        
        // then
        waitForExpectations(timeout: 1) { (error) in
            XCTAssertNil(error, "not all expectations fulfilled")
        }
    }
    
//    func testEmitEvent() {
//        // given
//        
//        let eventName = "Test"
//        let eventData = ["test":"test"]
//        let eventCID = UUID().uuidString
//        
//        let logger = MockLogger()
//        let infoLogExpectation = expectation(description: "Emitted event:\n cid: \(eventCID)\n name: \(eventName)\n data: \(eventData)")
//        logger.infoExpectation = infoLogExpectation
//        let mockWebSocket = MockWebSocket()
//        let socketCluster = SocketClusterRealization.init(with: mockWebSocket, url: rightConnectionStringStub, logger: logger)
//        let promise = expectation(description: "Event completion called")
//        
//        // when
//        let event: Event = EventImplementation(name: eventName, data: eventData, cid: eventCID) { (reponse) in
//            promise.fulfill()
//        }
//        socketCluster.emit(event: event)
//        
//        // then
//        waitForExpectations(timeout: 1, handler: nil)
//        
//    }

    
}
