import UIKit

protocol HomeScreenProtocol: AnyObject{ //AnyObject ile bu protokolün sadece sınıflara uygulanabilir olduğuna emiin oluyoruz
    func configureVC()
    func configureCollectionView()
    func reloadCollectionView()     //yeni veriler geldiğinde collection viewi güncellemek için
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
    func reloadCollectionView(){
        collectionView.reloadOnMainThread() //UICollectionView+Ext sınıfına yazdığımız fonk çağırdık

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
    func scrollViewDidScroll(_ scrollView: UIScrolView){
        //Main theread ta reload etmesini istiyoruz
        DispatchQueue.main.async{
            self.collectionView.reloadData  //Clouserin içerisinde olduğu için self yazılıyor
        }

    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.getDetail(id: viewModel.movies[indexPath.item]._id)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrolView){
        let offsetY = scroolViewcontentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        print("offsetY: \(offsetY)")                //11786.333  aşağı inildikçe tek bu artar
        print("contentHeight: \(contentHeight)")    //13600.0    scroolViewin uzunluğu
        print("height: \(height)")                  //926        ekran buyutu
        print("")

        //Scrollun %80 ine gelindiğini hesaplıyoruz sona yaklaştığımızda istek atabilmek için
        if offsetY > contentHeight - (2 * height) {
            viewModel.getMovies()
        }
    }
}