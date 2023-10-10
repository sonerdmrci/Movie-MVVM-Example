import Foundation
//HomeSreende olacak herşeye viewModeli karar verecek
//herşeyine erişimi kısıtlamak için protocol yazıyoruz

protocol HomeViewModelProtocol {
    var view: HomeScreenProtocol? {get set}
    func viewDidLoad()
    func getMovies()  // Servisten veriyi çekmek için 
}

final class HomeViewModel {
    //weak protocole verilmez bundan biz bir klasa conform ettiğimiz için emiiniz verdiğimize
    //ve bunu belirtmek için HomeScreen protokolüne AnyObject keywordunu uyguladık sınıflara uygulanabilir olduğundan emiin olduk 
    weak var view: HomeScreenProtocol? //burayı gösteren view e zayıf olmasını buraya fazla yüklenmemesini söylüyoruz bunu yapmazsak sürekli initilazed olacak
    private let service = MovieService()   //servis katmanı ile bağlantı kurduk
    var movies: [MovieResult] = []

}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad(){
        view?.configureVC()
        view?.configureCollectionView()  //collection viewin özelliklerini verdik ve burada çalıştırıyoruz
        getMovies()
    }
    func getMovies(){
        service.downloadMovie(page: page){[weak self] returnedMovies in //returnedMovies = Dönen filimler
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else {return}

            self.movies.append(contentsOf: returnedMovies)
            self.page += 1               //Hesapladığımız gibi %80 civarlarına inildğiğnde tekrar istek atıcak
            self.view?.reloadCollectionView() 
        }
    }

    func getDetail(){
        service.downloadDetail(id: id){ [weak self] returnedDetail in
            guard let self = self else { return }

            guard let returnedDetail = returnedDetail else { return }

            self.view.navigateToDetailScreen(movie: returnedDetail)

        }
    }
    
}