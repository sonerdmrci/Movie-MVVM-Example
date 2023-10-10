//cocoa touch file ile oluşturup UIImageViewi seçtik

import UIKit

final class PosterImageView: UIImageView{

    private var dataTask: URLSessionDataTask? //URLSessionun referansını tutar

    override init(frame: CGRect){
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false //storyboard olmadığı için
    }
    required init?(coder: NSCoder){
        fatalError("init (coder: ) has not been implemented")
    }
    func downloadImage(movie: MovieResult){
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else { return }

        NetvorkManager.shared.download(url: ){ [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            case .failure(_):
                break
            }
        }
        dataTask?.resume()
    }
    //Çok hızlı kaydırıldığında fotoğrafların indirilmesini iptal etmek istiyoruz
    func cancelDownloading() {
        dataTask.cancel()
        dataTask = nil
    }

}