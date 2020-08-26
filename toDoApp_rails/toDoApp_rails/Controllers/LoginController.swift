//
//  LoginController.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/26.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class LoginController: UIViewController{
    
    // MARK: - Properties
    
    private let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("ログイン", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        return button
    }()
    
    
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    
    
    // MARK: - Helpers
    
    func configureContainerView(){
        
    }
    
    func configureUI(){
        
        configureGradientLayer()
        
        view.addSubview(loginButton)
        loginButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 64, paddingLeft: 16, paddingRight: 16 ,height: 48)
        loginButton.layer.cornerRadius = 6
    }
    
}
