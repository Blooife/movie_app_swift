import Foundation
import Firebase

class UsersManager: ObservableObject{
    @Published var currentUserData: UserData?
    private var uid: String?
    private var db = Firestore.firestore()
    
    private var userCollection: CollectionReference {
        return db.collection("users")
    }
    
    init(uid: String?) {
        self.uid = uid
        self.fetchUserData()
    }
    
    func fetchUserData() {
        guard let uid = uid else { return }
        userCollection.document(uid).addSnapshotListener { [weak self] (documentSnapshot, error) in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            guard let data = document.data() else {
                print("Document data was empty.")
                return
            }
            self?.currentUserData = self?.userDataFromSnapshot(data: data, uid: uid)
        }
    }

    private func userDataFromSnapshot(data: [String: Any], uid: String) -> UserData {
        let name = data["name"] as? String ?? ""
        let surname = data["surname"] as? String ?? ""
        let birthdayTimestamp = data["birthDate"] as? Timestamp ?? Timestamp(date: Date())
        let birthDate = birthdayTimestamp.dateValue()
        let gender = data["gender"] as? Bool ?? true
        let country = data["country"] as? String ?? ""
        let phoneNumber = data["phoneNumber"] as? String ?? ""
        let city = data["city"] as? String ?? ""
        let about = data["about"] as? String ?? ""
        let favCountry = data["favCountry"] as? String ?? ""
        let favGenre = data["favGenre"] as? String ?? ""
        let favorites = data["favorites"] as? [String] ?? []

        return UserData(uid: uid, name: name, surname: surname,
                        birthDate: birthDate, gender: gender, country: country,
                        phoneNumber: phoneNumber, city: city, about: about,
                        favCountry: favCountry, favGenre: favGenre, favorites: favorites)
    }
    
    func createUserData() async throws {
        guard let uid = uid else { return }
        let userData = [
            "name": "",
            "surname": "",
            "birthDate": Timestamp(date: Date()),
            "gender": true,
            "country": "",
            "phoneNumber": "",
            "city": "",
            "about": "",
            "favCountry": "",
            "favGenre": "",
            "favorites": []
        ] as [String : Any]
        try await userCollection.document(uid).setData(userData)
    }

    func updateUserData(name: String, surname: String, birthDate: Date, gender: Bool,
                        country: String, phoneNumber: String, city: String, about: String,
                        favCountry: String, favGenre: String) async throws {
        guard let uid = uid else { return }
        let userData = [
            "name": name,
            "surname": surname,
            "birthDate": Timestamp(date: birthDate),
            "gender": gender,
            "contry": country,
            "phoneNumber": phoneNumber,
            "city": city,
            "about": about,
            "favCountry": favCountry,
            "favGenre": favGenre
        ] as [String : Any]
        try await userCollection.document(uid).updateData(userData)
    }

    func updateUserFavMovies(favorites: [String]) async throws {
        guard let uid = uid else { return }
        try await userCollection.document(uid).updateData(["favorites": favorites])
    }

    func deleteUserData() async throws {
        guard let uid = uid else { return }
        try await userCollection.document(uid).delete()
    }
}

