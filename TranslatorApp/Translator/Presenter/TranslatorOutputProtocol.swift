//
//  ProfileOutput.swift
//  TranslatorApp
//
//  Created by Abdulla on 21.01.2026.
//

import UIKit

protocol TranslatorOutputProtocol {
    func translateText(text: String, from: String, to: String)
    func saveFavourite()
    func getCount() -> Int
    func getFavourite(index: Int) -> Translation
    func getData(index: Int) -> Translation
}
