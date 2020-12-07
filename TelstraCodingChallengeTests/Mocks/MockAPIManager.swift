@testable import TelstraCodingChallenge

final class MockAPIManager: APIManaging {

    var requestDataCompletion: Action<DataResult>?
    private(set) var requestPath: String?
    private(set) var requestIsImage: Bool = false
    private(set) var requestMethod: HTTPMethod = .get

    func request(
        path: String,
        isImage: Bool = false,
        method: HTTPMethod = .get,
        timeout: Double = 20,
        completion: @escaping Action<DataResult>
    ) {
        requestPath = path
        requestIsImage = isImage
        requestMethod = method
        requestDataCompletion = completion
    }
}
