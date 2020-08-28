//
//  UploadToDoController.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class UploadToDoController: UIViewController{
    
    // MARK: - Properties
    
    
    
    private let toDoTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = true
        return tv
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPLOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.isEnabled = false
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    // MARK: - Helpers
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        navigationItem.title = "new ToDo"
        
        view.addSubview(uploadButton)
        uploadButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, height: 48)
        uploadButton.layer.cornerRadius = 6
        
        view.addSubview(toDoTextView)
        toDoTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: uploadButton.topAnchor, right: view.rightAnchor,
                            paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        
    }
    
    
}
