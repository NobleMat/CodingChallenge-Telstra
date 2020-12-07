import Foundation

enum APIError: Error {
    case unknown
    case urlError
    case cannotProcessData
}

protocol APIManaging {

    /// Request to the URL using the given path, method and headers
    /// - Parameters:
    ///   - path: The path to be appended to the base URL
    ///   - isImage: If the request is for an image, it uses a differect data check
    ///   - method: The HTTP method to be used
    ///   - timeout: The timeout to be used for the request
    ///   - completion: A completion that returns the data result
    func request(
        path: String,
        isImage: Bool,
        method: HTTPMethod,
        timeout: Double,
        completion: @escaping Action<DataResult>
    )
}

extension APIManaging {

    func request(
        path: String,
        isImage: Bool = false,
        method: HTTPMethod = .get,
        timeout: Double = 20,
        completion: @escaping Action<DataResult>
    ) {
        request(path: path, isImage: isImage, method: method, timeout: timeout, completion: completion)
    }
}
