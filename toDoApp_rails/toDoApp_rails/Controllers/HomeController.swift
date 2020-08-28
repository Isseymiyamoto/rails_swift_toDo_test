//
//  HomeController.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeController: UITableViewController{
    
    // MARK: - Properties
    
    private var toDos = [String]()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.setDimensions(height: 24, width: 24)
        button.contentMode = .scaleAspectFit
        button.clipsToBounds = true
        return button
    }()
    
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        configureTableView()
    }
    
    
    // MARK: - Helpers
    
    func configureTableView(){
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        
        view.addSubview(actionButton)
        actionButton.setDimensions(height: 56, width: 56)
        actionButton.layer.cornerRadius = 56 / 2
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 16, paddingRight: 24)
        
    }
    
    func configureNavigationBar(){
        navigationItem.title = "ToDo List"
    }
    
}

// MARK: - UITableViewDelegate

extension HomeController{
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: \(indexPath.row)番目のToDoです")
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: - UITableViewDataSource

extension HomeController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = toDos[indexPath.row]
        return cell
    }
}
