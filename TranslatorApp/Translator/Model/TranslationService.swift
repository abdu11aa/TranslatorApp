//
//  TranslationService.swift
//  TranslatorApp
//
//  Created by Abdulla on 26.01.2026.
//

import UIKit

class TranslationService {
    private let googleApi = "AIzaSyA6LXpVqzH5iO8SEluTOhVlflwuca_7ONY"
    func translatedText(text: String, from: String, to: String, completion: @escaping (String) -> Void) {
        let urlString = "https://translation.googleapis.com/language/translate/v2?q=\(text)&target=\(to)&source=\(from)&key=\(googleApi)"
        guard let url = URL(string: urlString) else { return completion("") }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            let decoded = try? JSONDecoder().decode(TranslateResult.self, from: data)
            let text = decoded?.data.translations.first?.translatedText
            DispatchQueue.main.async {
//                self.translateView.changeText(text: text ?? "Not able to translate")
                completion(text ?? "Choose different languages in order to get the translation" )
            }
        }.resume()
    }
}
