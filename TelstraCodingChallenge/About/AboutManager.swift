protocol AboutManaging {
    func fetchData(completion: @escaping Action<DecodableResult<About>>)
}

final class AboutManager {

    // MARK: - Enums
    private enum Constants {
        static let pathUrl: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
    }

    // MARK: - Properties

    // MARK: Private

    private let apiManager: APIManaging

    // MARK: - Initializers

    init(apiManager: APIManaging = API) {
        self.apiManager = apiManager
    }
}

// MARK: - Conformance

// MARK: AboutManaging

extension AboutManager: AboutManaging {

    func fetchData(completion: @escaping Action<DecodableResult<About>>) {
        apiManager.request(path: Constants.pathUrl) { result in
            result.responseDecodable(completion: completion)
        }
    }
}
