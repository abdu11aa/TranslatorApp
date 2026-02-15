//
//  ProfilePresenter.swift
//  TranslatorApp
//
//  Created by Abdulla on 14.01.2026.
//
import UIKit

class ProfilePresenter: ProfileOutputProtocol {
    
    private let randomService = RandomPhotoService()
    weak var input: ProfileInputProtocol?
    
    // UserDefaultsManager
    
    init(viewCont: ProfileInputProtocol? = nil) {
        self.input = viewCont
    }
    
    func getImage() {
        randomService.fetchPhotos { image in
            guard let image else {return}
            DispatchQueue.main.async {
                self.input?.updateImage(image: image)
            }
        }
    }
    
    func getDefaultImage() {
        let resString = UserDefaults.standard.string(forKey: "url") ?? ""
        guard let photoUrl = URL(string: resString) else {
            return
        }
        randomService.loadImage(photoUrl: photoUrl) { image in
            guard let image else {return}
            self.input?.updateImage(image: image)
        }
    }
    
    func saveStringFor(field: String, text: String) {
        UserDefaults.standard.set(text, forKey: field)
    }
    
    func getDefaultData(field: String) -> String? {
        UserDefaults.standard.string(forKey: field)
    }
    
    func setDefaultData() {
        let defaultName = UserDefaults.standard.string(forKey: "Name") ?? ""
        let defaultUsername = UserDefaults.standard.string(forKey: "Username") ?? ""
        let defaultPhoneNumber = UserDefaults.standard.string(forKey: "Phone number") ?? ""
        self.input?.setDefaults(defaultName: defaultName, defaultUsername: defaultUsername, defaultPhoneNumber: defaultPhoneNumber)
    }
}
