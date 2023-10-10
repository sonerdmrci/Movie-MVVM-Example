import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init(){}

    @discarableResult  //Uyarı almıyoruz
    func download(url: URL, complation: @escaping (Result<Data, Error>) -> ()) ->URLSessionDataTask{
        let dataTask = URLSession.shared.dataTask(with: url){data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                complation(.failure(error))
                return
            }

            guard
                let response = response as? HTTPURLResponse,
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