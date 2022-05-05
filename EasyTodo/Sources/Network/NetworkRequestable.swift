import Foundation

protocol NetworkRequestable {

}

extension NetworkRequestable {
    func makeRequest<T: Decodable>(_ url: URL) async -> Result<T, AppErrors> {
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return .success(decoded)
        } catch is URLError {
            return .failure(AppErrors.connectionError)
        } catch is DecodingError {
            return .failure(AppErrors.corruptedData)
        } catch {
            return .failure(AppErrors.badResponse)
        }
    }
}
