import Foundation

class Movie: Identifiable, Codable, Hashable {
    
    let uid: String
    let name: String
    let year: Int
    let description: String
    let country: String
    let genre: String
    let picture: [String]

    var isFav: Bool = false

    init(uid: String, name: String, year: Int, description: String, country: String, genre: String, picture: [String]) {
        self.uid = uid
        self.name = name
        self.year = year
        self.description = description
        self.country = country
        self.genre = genre
        self.picture = picture
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.uid == rhs.uid
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
}

