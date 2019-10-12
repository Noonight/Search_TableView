//
//  ViewController.swift
//  TourneySearch
//
//  Created by ayur on 11.10.2019.
//  Copyright © 2019 ayur-team. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.borderStyle = .roundedRect
        textField.placeholder = "Start taping here..."
        textField.clearButtonMode = .always
        
        return textField
    }()
    private var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.lightGray
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        return view
    }()
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorInset = .zero // separator full width
        
        return tableView
    }()
    
    private var dataSource = ["Hello", "World", "And", "Constraints"]
    private var filteredDataSource: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupViews()

        textField.addTarget(self, action: #selector(textDidChange(_:)), for: .editingChanged)
    }
    
    @objc func textDidChange(_ sender: UITextField) {
        guard let text = sender.text else { return }
        if isFiltering() {
            for item in dataSource {
                if item.contains(text) && !filteredDataSource.contains(item) {
                    filteredDataSource.append(item)
                }
            }
            tableView.reloadData()
        } else {
            tableView.reloadData()
        }
    }
    
    func isFiltering() -> Bool {
        guard let text = self.textField.text else { return false }
        if text.isEmpty {
            return false
        }
        return true
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(textField)
        
        textField.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor, constant: 16.0).isActive = true
        textField.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 16.0).isActive = true
        textField.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor, constant: -16.0).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        self.view.addSubview(separatorView)
        
        separatorView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        separatorView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        separatorView.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 16.0).isActive = true
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.separatorView.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return filteredDataSource.count
        }
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if isFiltering() {
            cell.textLabel?.text = filteredDataSource[indexPath.row]
        } else {
            cell.textLabel?.text = dataSource[indexPath.row]
        }
        
        return cell
    }
}

