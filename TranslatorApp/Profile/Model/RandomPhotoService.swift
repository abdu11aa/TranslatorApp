//
//  RandomPhotoService.swift
//  TranslatorApp
//
//  Created by Abdulla on 14.01.2026.
//
import UIKit

struct Result: Codable {
    let id: String
    let urls: URLS
}

struct URLS: Codable {
    let regular: String
}

class RandomPhotoService {
    
    let urlString =  "https://api.unsplash.com/photos/random?client_id=-8cf75Fl02njsLHm4uqYZUB5K8cHeaKKanJDwtnY9C4"
    
    func fetchPhotos(completion: @escaping (UIImage?) -> ()){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let jsonResult = try JSONDecoder().decode(Result.self, from: data)
                DispatchQueue.main.async { // no need to main
                    let resString = (jsonResult.urls.regular)
                    //print(resString)
                    UserDefaults.standard.set(resString, forKey: "url")
                    guard let photoUrl = URL(string: resString) else {
                        return
                    }
                    self.loadImage(photoUrl: photoUrl, completion: completion)
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    func loadImage(photoUrl: URL, completion: @escaping (UIImage?) -> ()){
        let task2 = URLSession.shared.dataTask(with: photoUrl) { data, _, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async {
                completion(UIImage(data: data))
            }
        }
        task2.resume()
    }
}
