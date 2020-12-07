@testable import TelstraCodingChallenge
import XCTest

class AboutManagerTests: XCTestCase {

    private var manager: AboutManager!
    private var mockManager: MockAPIManager!

    override func setUp() {
        super.setUp()

        configure()
    }

    func testFetchSuccess() {

        mockManager.requestDataCompletion?(.success(Data()))
        manager.fetchData { result in
            XCTAssertEqual(self.mockManager.requestPath, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
            XCTAssertFalse(self.mockManager.requestIsImage)
            XCTAssertEqual(self.mockManager.requestMethod, .get)

            if case .success(let data) = result {
                XCTAssertNotNil(data)
            } else {
                XCTFail("Result is not expected value")
            }
        }
    }

    func testFetchFailure() {
        mockManager.requestDataCompletion?(.failure(APIError.unknown))
        manager.fetchData { result in
            XCTAssertEqual(self.mockManager.requestPath, "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json")
            XCTAssertFalse(self.mockManager.requestIsImage)
            XCTAssertEqual(self.mockManager.requestMethod, .get)

            guard case .failure = result else {
                XCTFail("Result is not expected value")
                return
            }
        }
    }
}

private extension AboutManagerTests {

    func configure(mockManager: MockAPIManager = .init()) {
        self.mockManager = mockManager
        manager = .init(apiManager: mockManager)
    }
}
