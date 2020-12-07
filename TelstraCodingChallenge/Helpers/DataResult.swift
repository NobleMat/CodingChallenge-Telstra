import Foundation

typealias DataResult = Result<Data, Error>
typealias DecodableResult<Response: Decodable> = Result<Response, Error>

extension DataResult {

    /// This function converts a DataResult into a DecodableResult
    /// - Parameters:
    ///   - type: The type for the converted response
    ///   - queue: The queue that the response should be in
    ///   - decoder: JSONDecoder incase you need to use a custom decoder
    ///   - completion: The completion block that returns the converted response
    /// - Returns: self since this is discardable
    @discardableResult
    func responseDecodable<Response: Decodable>(
        of type: Response.Type = Response.self,
        queue: DispatchQueue = .main,
        decoder: JSONDecoder = .init(),
        completion: @escaping (DecodableResult<Response>) -> Void
    ) -> Self {
        guard case .success(let dataResponse) = self,
            let jsonString = String(data: dataResponse, encoding: .ascii),
            let acceptableData = jsonString.data(using: .utf8, allowLossyConversion: false)
        else {
            queue.async {
                completion(.failure(APIError.cannotProcessData))
            }
            return self
        }
        do {
            let response = try decoder.decode(type, from: acceptableData)
            queue.async {
                completion(.success(response))
            }
            return self
        } catch {
            queue.async {
                completion(.failure(APIError.cannotProcessData))
            }
            return self
        }
    }
}
