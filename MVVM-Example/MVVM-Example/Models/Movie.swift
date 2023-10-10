import Foundation

struct Movie{
    let results: [MovieResult]?
}

struct MovieResult {
    let id: Int?
    let posterPath: String?
    let overview, releaseDate, title: String?

    enum CodingKeys: String, CodingKey{ //Caselere string değer atayabilmek için Stringi conform ettik
        case id
        case posterPath = "poster_path"
        case overview, title
        case releaseDate = "release_date"
    }    

    //opsiyonelden kurtulmak için compitut propartiy ile
    var _id: Int {
        id ?? Int.min
    }

    var _posterPath: String {
        posterPath ?? ""
    }
}