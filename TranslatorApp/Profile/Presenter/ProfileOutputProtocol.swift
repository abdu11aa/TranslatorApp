//
//  ProfileInput.swift
//  TranslatorApp
//
//  Created by Abdulla on 14.01.2026.
//

import UIKit

protocol ProfileOutputProtocol {
    func getImage()
    func saveStringFor(field: String, text: String)
    func getDefaultData(field: String) -> String?
    func getDefaultImage()
    func setDefaultData()
}

