//
//  CustomTableViewCell.swift
//  TranslatorApp
//
//  Created by Abdulla on 11.02.2026.
//

import UIKit

protocol CustomCellProtocol {
    func showTranslationWith(index: Int)
}

class CustomTableViewCell: UITableViewCell {
    
    static let identifier = "CustomCell" // must be same as classname
    private var index: Int = -1
    var delegate: CustomCellProtocol? = nil
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(showTranslation), for: .touchUpInside)
        return button
    }()
    let translationLabel: UILabel = {
        let label = UILabel()
        label.text = "check"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let fromLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "KZ"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let toLanguageLabel: UILabel = {
        let label = UILabel()
        label.text = "RU"
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(translation: Translation, index: Int, delegate: CustomCellProtocol){
        translationLabel.text = translation.outputText
        
        changeLabel1(code: translation.outputLanguage)
        changeLabel2(code: translation.inputLanguage)
        
        self.delegate = delegate
        self.index = index
    }
    
    private func setupUI(){
        addSubview(translationLabel)
        addSubview(fromLanguageLabel)
        addSubview(toLanguageLabel)
        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            translationLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            translationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            
            fromLanguageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            fromLanguageLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 1.5),
            
            toLanguageLabel.leadingAnchor.constraint(equalTo: fromLanguageLabel.trailingAnchor, constant: 10),
            toLanguageLabel.topAnchor.constraint(equalTo: translationLabel.bottomAnchor, constant: 1.5),
            
            button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            button.topAnchor.constraint(equalTo: topAnchor, constant: 10)
        ])
    }
    @objc private func showTranslation(){
        delegate?.showTranslationWith(index: index)
    }
    
    func changeLabel1(code: String?){
        if (code == "kk") { toLanguageLabel.text = "Kazakh" }
        else if (code == "ru") { toLanguageLabel.text = "Russian" }
        else { toLanguageLabel.text = "English" }
    }
    
    func changeLabel2(code: String?){
        if (code == "kk") { fromLanguageLabel.text = "Kazakh ->" }
        else if (code == "ru") { fromLanguageLabel.text = "Russian ->" }
        else { fromLanguageLabel.text = "English ->" }
    }
}
