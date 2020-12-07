protocol AboutManaging {
    func fetchData(completion: @escaping Action<DecodableResult<About>>)
}

final class AboutManager: AboutManaging {

    private let apiManager: APIManaging

    init(apiManager: APIManaging = API) {
        self.apiManager = apiManager
    }

    func fetchData(completion: @escaping Action<DecodableResult<About>>) {
        let pathURL: String = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"

        apiManager.request(path: pathURL) { result in
            result.responseDecodable(completion: completion)
        }
    }
}
