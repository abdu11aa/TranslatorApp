//
//  ProfilePresenter.swift
//  TranslatorApp
//
//  Created by Abdulla on 21.01.2026.
//
import UIKit
struct Translation {
    let inputLanguage: String
    let outputLanguage: String
    let inputText: String
    let outputText: String
}

class TranslatorPresenter: TranslatorOutputProtocol {
  
    private let translationService = TranslationService()
    weak var input: TranslatorInputProtocol?
    
    var favourites: [Translation] = []
    var currentTranslation: Translation?
    
    init(viewCont: TranslatorInputProtocol? = nil) {
        self.input = viewCont
    }

    func translateText(text: String, from: String, to: String) {
        currentTranslation = nil
        translationService.translatedText(text: text, from: from, to: to) { [weak self] outputText in
            self?.input?.translatedText(text: outputText)
            let current = Translation(inputLanguage: from, outputLanguage: to, inputText: text, outputText: outputText)
            self?.currentTranslation = current
        }
    }
    func saveFavourite() {
        guard let currentTranslation else { return  }
        favourites.append(currentTranslation)
        input?.updateData()
    }
    func getCount() -> Int {
        return favourites.count
    }
    func getFavourite(index: Int) -> Translation {
        return favourites[index]
    }
    func getData(index: Int) -> Translation {
        return favourites[index]
    }
    
}
