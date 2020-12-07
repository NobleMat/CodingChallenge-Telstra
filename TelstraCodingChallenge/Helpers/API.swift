import Foundation

let API = APIManager.default

class APIManager {

    // MARK: - Properties

    // MARK: Public

    static let `default` = APIManager()
}

// MARK: - Conformance

// MARK: APIManaging

extension APIManager: APIManaging {

    func request(
        path: String,
        isImage: Bool = false,
        method: HTTPMethod = .get,
        timeout: Double = 20,
        completion: @escaping Action<DataResult>
    ) {
        guard
            let url = URL(string: path)
        else {
            return completion(.failure(APIError.urlError))
        }
        var urlRequest: URLRequest = URLRequest(
            url: url,
            timeoutInterval: timeout
        )
        urlRequest.httpMethod = method.value
        request(urlRequest: urlRequest, completion: completion)
    }
}

// MARK: - Private Helpers

// MARK: Fetch data

private extension APIManager {

    func request(
        urlRequest: URLRequest,
        isImage: Bool = false,
        completion: @escaping Action<DataResult>
    ) {
        if !NetworkManager.isConnectedToNetwork() {
            return completion(.failure(APIError.cannotProcessData))
        }
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if error.isNil {
                guard (response as? HTTPURLResponse)?.statusCode == 200,
                    let data = data
                else {
                    completion(.failure(APIError.cannotProcessData))
                    return
                }

                if !isImage {
                    completion(.success(data))
                } else if let mimeType = response?.mimeType,
                    mimeType.hasPrefix("image") {
                    completion(.success(data))
                }
            } else {
                return completion(.failure(APIError.cannotProcessData))
            }
        }.resume()
    }
}
