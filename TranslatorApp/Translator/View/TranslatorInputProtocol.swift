//
//  ProfileInputProtocol.swift
//  TranslatorApp
//
//  Created by Abdulla on 21.01.2026.
//
import UIKit

protocol TranslatorInputProtocol: AnyObject {
    func translatedText(text: String)
    func updateData()
}
