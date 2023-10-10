import Foundation

final class MovieService {
    func downloadMovie(page: Int, complation: @escaping ([MovieResult]?) -> ()){
        guard let url = URL(string: APIURLs.movies(page: page) ) else
            {return}
        //NetvorkManager sınıfındaki complation çalışır 
        //Escaping kullandığımız için weak self kullandık
        NetworkManager.shared.download(url: url){[weak self ] result in
            //data başarıyla geldiğinde burası çalışır
            guard let self = self else {return}
            switch result {
            case .success(let data):
                complation(self.handleWithData(data))
            case .failure(let error):
                self.handleWithError(error)
            }
        }
    }

    func downloadDetail(id: Int, complation: @escaping (MovieResult?) -> ()){
        guard let url = URL(string: APIURLs.detail(id: id)) else {return}
    }

    private func handleWithError(_ error: Error){ // _ koymamızın sebebi dışarıda verdiğimiz değişkeni kullanmamıza gerk kalmaması için
        print(error.localizedDescription)
    }
    private funk handleWithData(_ data: Data) -> [MovieResult]?{
        //results modelinin değerine ulaşmak için ilk Movie ye ulaşmalıyız
        //JSONDecoderkullanmalıyız bunun için error thorow edeceği için try catch içine alıyoruz
        do {
            //hata fırlatabileceği için try yazdık denemek için
           let movie = try JSONDecoder().decode(Movie.self, from: data) //Movie.self vermemizin sebebi Movienin tipini almak için
            return movie.results
        } catch  {  //let error var catch yanında ama yazılmaz
            print(error)
            return nil 
        }
    }
}