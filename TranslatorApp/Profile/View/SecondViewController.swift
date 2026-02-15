//
//  ViewController.swift
//  TranslatorApp
//
//  Created by Abdulla on 27.12.2025.
//

import UIKit

class SecondViewController: UIViewController {
    private lazy var presenter = ProfilePresenter(viewCont: self)
    private lazy var output: ProfileOutputProtocol = presenter
    
    private let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "DevHouse IOS"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let name = CustomTextFieldView(title: "Name", placeholder: "Your name")
    private let username = CustomTextFieldView(title: "Username", placeholder: "Your username")
    private let phoneNumber = CustomTextFieldView(title: "Phone number", placeholder: "Your phone number")
    
    private lazy var setPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Set random photo", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(photoButtonPressed), for: .touchUpInside)
        return button
    }()
    
    private let profilePhoto: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "avatar.jpg")
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.layer.cornerRadius = 60
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configureDelegates()
        output.setDefaultData()
        output.getDefaultImage()
    }
    
    private func setupUI(){
        view.backgroundColor = .white

        view.addSubview(mainLabel)
        view.addSubview(profilePhoto)
        view.addSubview(name)
        view.addSubview(username)
        view.addSubview(phoneNumber)
        view.addSubview(setPhotoButton)
        
        NSLayoutConstraint.activate([
            
            mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            
            profilePhoto.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profilePhoto.topAnchor.constraint(equalTo: mainLabel.topAnchor, constant: 55),
            profilePhoto.heightAnchor.constraint(equalToConstant: 120),
            profilePhoto.widthAnchor.constraint(equalToConstant: 120),
            
            name.topAnchor.constraint(equalTo: profilePhoto.topAnchor, constant: 155),
            name.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            name.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            name.heightAnchor.constraint(equalToConstant: 20),

            username.topAnchor.constraint(equalTo: name.topAnchor, constant: 40),
            username.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            username.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            username.heightAnchor.constraint(equalToConstant: 20),
           
            phoneNumber.topAnchor.constraint(equalTo: username.topAnchor, constant: 40),
            phoneNumber.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            phoneNumber.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            phoneNumber.heightAnchor.constraint(equalToConstant: 20),
           
            setPhotoButton.topAnchor.constraint(equalTo: phoneNumber.topAnchor, constant: 80),
            setPhotoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 25),
            setPhotoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25),
        ])
    }
    
    private func configureDelegates() {
        name.delegate = self
        username.delegate = self
        phoneNumber.delegate = self
    }
    @objc private func photoButtonPressed(_ sender: UIButton){
        output.getImage()
    }
    
}

extension SecondViewController: ProfileInputProtocol {
    func updateImage(image: UIImage) {
        self.profilePhoto.image = image
    }
    func setDefaults(defaultName: String, defaultUsername: String, defaultPhoneNumber: String) {
        name.setText(text: defaultName)
        username.setText(text: defaultUsername)
        phoneNumber.setText(text: defaultPhoneNumber)
    }
}

extension SecondViewController: CustomTextFieldProtocol {
    func saveStringFor(field: String, text: String) {
         output.saveStringFor(field: field, text: text) 
    }
}
