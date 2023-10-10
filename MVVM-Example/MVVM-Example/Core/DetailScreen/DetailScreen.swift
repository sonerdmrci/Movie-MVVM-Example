import UIKit


protocol DetailScreenProtocol: AnyObject{ // AnyObject verdiğimiz için sadece claslar conform edebilir
    func configureVC()
    func configurePosterImageView()
    func downloadPosterImage()
    func configureTitleLabel()
    func configureDateLabel()
    func configureOverviewLabel()
}

class DetailScreen: UIViewControler {

    private let movie: MovieResult

    private let viewModel = DetailViewModel()
    private let padding: CGFloat = 16

    private var posterImageView: PosterImageView!
    private var titleLabel: UILabel!
    private var dateLabel: UILabel!
    private var overviewLabel: UILabel! 

    init(movie: MovieResult){
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder){
        fatalError("init(coder: ) has not been implemented")
    }

    override func viewDidLoad(){
        super.viewDidLoad()

        viewModel.view = self
        viewModel.viewDidLoad()
    }
}

extension DetailScreen: DetailScreenProtocol{

    func configureVC(){

        view.backgroundColor = .systemBackground
    }

    func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        view.addSubview(posterImageView)

        posterImageView.layer.cornerRadius = 16
        posterImageView.clipsToBounds = true
        let posterWidth = CGFloat.deviceWidth * 0.4

        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            posterImageView.widthAnchor.constraint(equalToConstant: posterWidth),
            posterImageView.heightAnchor.constraint(equalToConstant: posterWidth * 1.5)
        ])
    }
    func downloadPosterImage() {
        posterImageView.downloadImage(movie: movie)
    }

    func configureTitleLabel(){
        titleLabel = UILabel(frame: .zero)
        view.addSubview(titleLabel)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.text = Movie._title
        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 2

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: padding) //posterImageView in sağ tarafı
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding) //Negatif vermemizin sebebi label ili ekranın sağında boşluk koymak
        ])
    }
    func configureDateLabel(){
        dateLabel = UILabel(frame: .zero)
        view.addSubview(dateLabel)

        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.text = Movie._releaseDate
        dateLabel.font = .systemFont(ofSize: 18)
        dateLabel.textColor = .secondaryLabel

        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3 * padding),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }
    func configureOverviewLabel(){
        overviewLabel = UILabel(frame: .zero)
        view.addSubview(overviewLabel)

        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        overviewLabel.text = Movie._overview
        overviewLabel.font = systemFont(ofSize: 16)
        overviewLabel.numberOfLines = 0
        
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 2 * padding)
            overviewLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor)
            overviewLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])

    }
}