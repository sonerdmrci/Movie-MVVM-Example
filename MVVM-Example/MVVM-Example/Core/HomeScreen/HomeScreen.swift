import UIKit

protocol HomeScreenProtocol: AnyObject{ //AnyObject ile bu protokolün sadece sınıflara uygulanabilir olduğuna emiin oluyoruz
    func configureVC()
    func configureCollectionView()
}

final class HomeScreen: UIViewController {
    //MARK: -Propairets
    private let viewModel = HomeViewModel()

    //MARK: -Object
    private var collectionView: UICollectionView()

    //MARK: -Life Cycle
    override func viewDidLoad(){
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

//MARK: -Extension HomeScreenProtocol
extension HomeScreen: HomeScreenProtocol{

    //MARK: -Functions
    func configureVC(){
        view.backgroundColor = .systemPink
    }

    func configureCollectionView(){


        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createHomeFlowLayout())
        view.addSubview(collectionView) //viewin alt görünümü olarak ekledik

        collectionView.translatesAutoresizingMaskIntoConstraints = false //storyboard olmadığı için
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)

        collectionView.topAnchor

        collectionView.pinToEdgesOf(view: view)
    
    }
}
//MARK: -CollectionView
extension HomeScreen: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSections section: Int) -> Int {
        viewModel.movies.count
    } 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Birden fazla cell oldugunda bunların hepsini tek tek yazmak yerine Reuseable şeklinde tutar
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.setCell(movie: viewModel.movies[indexPath.item])
    
    }
}