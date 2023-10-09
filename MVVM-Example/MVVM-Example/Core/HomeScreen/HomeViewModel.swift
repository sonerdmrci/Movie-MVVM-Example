import Foundation
//HomeSreende olacak herşeye viewModeli karar verecek
//herşeyine erişimi kısıtlamak için protocol yazıoruz

protocol HomeViewModelProtocol {
    var view: HomeScreenProtocol? {get set}
    func viewDidLoad()
    func getMovies()  // Servisten veriyi çekmek için 
}

final class HomeViewModel {
    //weak protocole verilmez bundan biz bir klasa conform ettiğimiz için emiiniz verdiğimize
    //ve bunu belirtmek için HomeScreen protokolüne AnyObject keywordunu uyguladık sınıflara uygulanabilir olduğundan emiin olduk 
    weak var view: HomeScreenProtocol? //burayı gösteren view e zayıf olmasını buraya fazla yüklenmemesini söylüyoruz
    private let service = MovieService()   //servis katmanı ile bağlantı kurduk
    var movies: [MovieResult] = []

}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad(){
        view?.configureVC()
        view?.configureCollectionView()  //collection viewin özelliklerini verdik ve burada çalıştırıyoruz
   
    }
    func get movies(){
        service.downloadMovie{[weak self] returnedMovies in //returnedMovies = Dönen filimler
            guard let self = self else { return }
            guard let returnedMovies = returnedMovies else {return}

            self.movies = returnedMovies
            print(returnedMovies)

        }
    }
    
}