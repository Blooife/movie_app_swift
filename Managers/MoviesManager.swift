import Foundation
import Firebase

class MoviesManager: ObservableObject{
    @Published var movies: [Movie] = []
    private var uid: String?
    private var db = Firestore.firestore()

    init(uid: String?) {
        self.uid = uid
        self.setupMoviesStateListener()
    }
    
    private func setupMoviesStateListener() {
        db.collection("movies").addSnapshotListener { [weak self] (querySnapshot, error) in
            if let snapshot = querySnapshot {
                self?.movies = self?.movieListFromSnapshot(snapshot) ?? []
            } else if let error = error {
                self?.movies = []
                print("Error getting movie documents: \(error)")
            }
        }
    }
    
    private func movieListFromSnapshot(_ snapshot: QuerySnapshot?) -> [Movie] {
            guard let snapshot = snapshot else { return [] }
            
            var movies = [Movie]()
            for document in snapshot.documents {
                let data = document.data()
                let uid = document.documentID
                if let name = data["name"] as? String,
                   let year = data["year"] as? Int,
                   let description = data["description"] as? String,
                   let country = data["country"] as? String,
                   let genre = data["genre"] as? String,
                   let picture = data["picture"] as? [String]	 {
                    
                    let movie = Movie(uid: uid, name: name, year: year, description: description,
                                  country: country, genre: genre, picture: picture)
                    movies.append(movie)
                }
            }
        print(movies.count)
            return movies
        }
}
