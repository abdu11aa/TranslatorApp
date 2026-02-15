//
//  CustomLabels.swift
//  TranslatorApp
//
//  Created by Abdulla on 15.01.2026.
//

import UIKit

protocol CustomTextFieldProtocol {
    func saveStringFor(field: String, text: String)
}

class CustomTextFieldView: UIView {
    
    var delegate: CustomTextFieldProtocol?
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .gray
        textField.textAlignment = .right
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    init(title: String, placeholder: String) {
        super.init(frame: .zero)
        label.text = title
        textField.placeholder = placeholder
        textField.delegate = self
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(label)
        addSubview(textField)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.topAnchor.constraint(equalTo: topAnchor),
            
            textField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 15),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            textField.topAnchor.constraint(equalTo: topAnchor),
        ])
    }
    
    func setText(text: String){
        textField.text = text
    }
    
}

extension CustomTextFieldView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.saveStringFor(field: label.text ?? "", text: textField.text ?? "")
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
