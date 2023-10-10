import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}

    @discarableResult  //Uyarı almıyoruz
    func download(url: URL, complation: @escaping (Result<Data, Error>) -> ()){
        let dataTask = URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error {
                print(error.localizedDescription)
                complation(.failure(error))
            }
            guard
                let response = response as? HTTPURLResponsive,
                response.statusCode == 200 else{
                    complation(.failure(URLError(.badServerResponse)))
                    return
                }
            guard let data = data else {
                complation(.failure(.badURL))
                return
            }
            complation(.success(data))
        }
        dataTask.resume()
        return dataTask
    }
}