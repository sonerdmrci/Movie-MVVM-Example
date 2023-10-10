import Foundation

//MARK: -Protocol
protocol DetailViewModelProtocol{
    var view: DetailScreenProtocol? {get set}

    func viewDidLoad()

}


final class DetailViewModel{
    weak var view: DetailViewModelProtocol?
}

//MARK: -DetailHomeModel Extensions
extension DetailViewModel: DetailViewModelProtocol{
    func viewDidLoad(){
        view?.configureVC()
        view?.configurePosterImageView()
        view?.configureTitleLabel()
        view?.configureDateLabel()
        view?.configureOverviewLabel()
    }
}