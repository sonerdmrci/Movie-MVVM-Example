import Foundation

struct Movie{
    let results: [MovieResult]?
}

struct MovieResult {
    let id: Int?                //Opsiyonel yapmamızın sebebi servisten boşta dönebilir
    let posterPath: String?
    let overview, releaseDate, title: String?

    enum CodingKeys: String, CodingKey{ //Caselere string değer atayabilmek için Stringi conform ettik
        case id
        case posterPath = "poster_path"
        case overview, title
        case releaseDate = "release_date"
    }    

    //opsiyonelden kurtulmak için compitut propartiy ile opsiyonellikten çıkardık
    var _id: Int {
        id ?? Int.min
    }

    var _posterPath: String {
        posterPath ?? ""
    }
    var _overview: String {
        overview ?? ""
    }
    var _title: String {
        title ?? "N/A"
    }
    var _releaseDate: String {
        releaseDate ?? "N/A"
    }
}