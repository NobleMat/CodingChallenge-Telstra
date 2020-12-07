@testable import TelstraCodingChallenge

final class MockAboutManager: AboutManaging {

    private(set) var fetchDataCalledCount: Int = 0
    private(set) var fetchDataCompletion: Action<DecodableResult<About>>?
    func fetchData(completion: @escaping Action<DecodableResult<About>>) {
        fetchDataCalledCount += 1
        fetchDataCompletion = completion
    }
}
