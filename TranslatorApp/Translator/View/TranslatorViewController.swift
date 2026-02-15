//
//  SecondViewController.swift
//  TranslatorApp
//
//  Created by Abdulla on 13.01.2026.
//

import UIKit

struct TranslateResult: Decodable {
    let data: DataArray
}

struct DataArray: Decodable {
    let translations: [TranslationModel]
}

struct TranslationModel: Decodable {
    let translatedText: String
}

class TranslatorViewController: UIViewController {
    private lazy var presenter = TranslatorPresenter(viewCont: self)
    private lazy var output: TranslatorOutputProtocol = presenter
    
    private let textView = CustomInputTextView()
    private let translateView = CustomOutputTextView()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "DevHouse"
        view.backgroundColor = .white
        setupUI()
        configureDelegates()
        tableView.dataSource = self
    }
    
    func setupUI() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textView)
        view.addSubview(translateView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: navigationItem.titleView?.bottomAnchor ?? view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.heightAnchor.constraint(equalToConstant: 200),
            
            translateView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 5),
            translateView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            translateView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            translateView.heightAnchor.constraint(equalToConstant: 200),
                        
            tableView.topAnchor.constraint(equalTo: translateView.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    private func configureDelegates(){
        textView.delegate = self
        //translateView.delegate = self
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 25
        
        translateView.translatesAutoresizingMaskIntoConstraints = false
        translateView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        translateView.clipsToBounds = true
        translateView.layer.cornerRadius = 25
    }
}

extension TranslatorViewController: TranslatorInputProtocol {
    func updateData() {
        tableView.reloadData()
    }
    
    func translatedText(text: String) {
        self.translateView.changeText(text: text)
    }
}
extension TranslatorViewController: textViewProtocol {
    func translate(text: String) {
        output.translateText(text: text, from: textView.getLanguage(), to: translateView.getLanguage())
    }
    func favouriteButtonWasPressed() {
        output.saveFavourite()
    }
}

extension TranslatorViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return output.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.identifier, for: indexPath) as? CustomTableViewCell else { fatalError("Error") }
        let translation = output.getFavourite(index: indexPath.row)
        cell.configure(translation: translation, index: indexPath.row, delegate: self)
        cell.selectionStyle = .none
        
        return cell
    }
}

extension TranslatorViewController: CustomCellProtocol {
    func showTranslationWith(index: Int) {
        textView.getFavouriteTranslation(translation: output.getData(index: index))
        translateView.getFavouriteTranslation(translation: output.getData(index: index))
    }
}

