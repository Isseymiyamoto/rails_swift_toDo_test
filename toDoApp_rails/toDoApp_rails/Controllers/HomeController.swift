//
//  HomeController.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

private let reuseIdentifier = "cell"

class HomeController: UIViewController{
    
    // MARK: - Properties
    
    private var user: User?
    private let tableView = UITableView()
    private var toDos = [ToDo](){
        didSet{ tableView.reloadData() }
    }
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .systemPurple
        button.tintColor = .white
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        button.imageView?.setDimensions(height: 24, width: 24)
        button.addTarget(self, action: #selector(handleShowUpload), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        fetchToDos()
        configureUI()

    }
    
    // MARK: - API
    
    func presentLoginScreen(){
        DispatchQueue.main.async {
            let controller = LoginController()
            controller.delegate = self
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self.present(nav, animated: true, completion: nil)
        }
    }
    
    func authenticateUser(){
        // loginしていなかったらLoginControllerに飛ばす
        if user == nil{
            presentLoginScreen()
        }
    }
    
    func fetchToDos(){
        ToDoService.shared.fetchToDos { (toDos) in
            self.toDos = toDos
        }
    }
    
    // MARK: - Selectors
    
    @objc func handleShowUpload(){
        let controller = UploadToDoController()
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        self.present(nav, animated: true)
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        navigationItem.title = "ToDo List"
        
        configureTableView()
        
        view.addSubview(actionButton)
        actionButton.setDimensions(height: 56, width: 56)
        actionButton.layer.cornerRadius = 56 / 2
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                                paddingBottom: 8, paddingRight: 24)
    }
    
    
    func configureTableView(){
        
        tableView.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.tableFooterView = UIView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.frame = view.frame
    }
    
  
  
    
}

// MARK: - UITableViewDelegate

extension HomeController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("DEBUG: \(indexPath.row)番目のToDoです")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
}

// MARK: - UITableViewDataSource

extension HomeController: UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: reuseIdentifier)
        cell.textLabel?.text = toDos[indexPath.row].memo 
        return cell
    }
}

// MARK: - AuthenticationDelegate

extension HomeController: AuthenticationDelegate{
    func authenticationComplete() {
        dismiss(animated: true, completion: nil)
        configureUI()
    }
}
