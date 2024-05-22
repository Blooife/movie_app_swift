import Foundation

class UserData {
    let uid: String
    let name: String
    let surname: String
    let birthDate: Date
    let gender: Bool
    let country: String
    let phoneNumber: String
    let city: String
    let about: String
    let favCountry: String
    let favGenre: String
    var favorites: [String]

    init(uid: String, name: String, surname: String, birthDate: Date, gender: Bool, country: String, phoneNumber: String, city: String, about: String, favCountry: String, favGenre: String, favorites: [String]) {
        self.uid = uid
        self.name = name
        self.surname = surname
        self.birthDate = birthDate
        self.gender = gender
        self.country = country
        self.phoneNumber = phoneNumber
        self.city = city
        self.about = about
        self.favCountry = favCountry
        self.favGenre = favGenre
        self.favorites = favorites
    }
}

