//Cocoa Touch Sınıfından CollectionViewCell oluşturuldu

import UIKit

final class MovieCell: UICollectionViewCell{ 
    static let reuseID = "MovieCell"

    private var posterImageView: PosterImageView!

    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
        configurePosterImageView()
    }
    required init?(coder: NSCoder){
        fatalError("init (coder:) has not been implemented")
    }

    //MARK: -Functins
    //Cell ler aşağı doğru inildikçe üsttekiler alta doğru kaydığında celler tekrar kullanılır ve onları sıfırlamalıyız
    //İnternetten dolayı alttaki fotoğraflar yüklenmezsse üstteki celler alta gelirken güncellenmiyor ve ierisindeki resimde geliyor
    override func prepareForReuse(){
        posterImageView.image = nil
        posterImageView.cancelDownloading
    }

    func setCell(movie: MovieResult){
        posterImageView.downloadImage(movie: movie)
    }

    private func configureCell(){
        backgroundColor = .systemGray5
        layer.cornerRadius = 16
        clipsToBounds = true     //İmage viewin köşelerini sığdırdı
    }
    private func configurePosterImageView() {
        posterImageView = PosterImageView(frame: .zero)
        addSubview(posterImageView)

        posterImageView.pinToEdgesOf(view: self)

    }

}