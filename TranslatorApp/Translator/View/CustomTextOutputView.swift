//
//  CustomView.swift
//  TranslatorApp
//
//  Created by Abdulla on 21.01.2026.
//

import UIKit


class CustomOutputTextView: UIView {
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        textView.font = .systemFont(ofSize: 30, weight: .bold)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.up.chevron.down"), for: .normal)
        button.setTitle("English (EN)", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13)
        
        let kazakh = UIAction(title: "KZ") { action in
            button.setTitle("Kazakh (KK)", for: .normal)
        }
        let russian = UIAction(title: "RU") { action in
            button.setTitle("Russian (RU)", for: .normal)
        }
        let english = UIAction(title: "EN") { action in
            button.setTitle("English (EN)", for: .normal)
        }
        button.menu = UIMenu(title: "Choose language", children: [kazakh, russian, english])
        button.showsMenuAsPrimaryAction = true
        button.semanticContentAttribute = .forceRightToLeft
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    init(){
        super.init(frame: .zero)
        textView.isEditable = false
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setup(){
        addSubview(button)
        addSubview(textView)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            
            textView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: button.topAnchor, constant: 25),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
    func changeText(text: String){
        textView.text = text
    }
    
    func getFavouriteTranslation(translation: Translation){
        textView.text = translation.outputText
        changeLabel(code: translation.outputLanguage)
    }
    
    func changeLabel(code: String){
        if (code == "kk") { button.setTitle("Kazakh (KK)", for: .normal) }
        else if (code == "ru") { button.setTitle("Russian (RU)", for: .normal) }
        else { button.setTitle("English (EN)", for: .normal) }
    }
    
    func getCurrentText() -> String {
        return textView.text
    }
    func getLanguage() -> String {
        if (button.currentTitle == "Kazakh (KK)") { return "kk" }
        else if (button.currentTitle == "Russian (RU)") { return "ru" }
        else { return "en" }
    }
}
