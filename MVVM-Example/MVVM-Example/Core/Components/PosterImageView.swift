//cocoa touch file ile oluşturup UIImageViewi seçtik

import UIKit

class PosterImageView: UIImageView{
    override init(frame: CGRect){
        super.init(frame: frame)

        translatesAutoresizingMaskIntoConstraints = false //storyboard olmadığı için
    }
    required init?(coder: NSCoder){
        fatalError("init (coder: ) has not been implemented")
    }
    func downloadImage(movie: MovieResult){
        guard let url = URL(string: APIURLs.imageURL(posterPath: movie._posterPath)) else { return }
        URLSession().shared.dataTask(with: url){ data, _, _ in
            guard let data = data else { return }
            
            self.image = UIImage()//TODO burada kaldım
        }
    }

}