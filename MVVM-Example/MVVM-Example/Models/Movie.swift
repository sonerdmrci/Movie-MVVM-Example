import Foundation

struct Movie{
    let results: [Results]
}

struct Results {
    let id: Int?
    let posterPath: String?

    enum CodingKeys: String, CodingKey{
        case id
        case posterPath = "poster_path"
    }    

    //opsiyonelden kurtulmak için compitut propartiy ile
    var _id: Int {
        id ?? Int.min
    }

    var _posterPath: String {
        posterPath ?? ""
    }
}