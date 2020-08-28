//
//  UploadToDoController.swift
//  toDoApp_rails
//
//  Created by 宮本一成 on 2020/08/28.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

protocol UploadControllerDelegate: class{
    func controller(_ controller: UploadToDoController)
}

class UploadToDoController: UIViewController{
    
    // MARK: - Properties
    
    weak var delegate: UploadControllerDelegate?
    
    private let toDoTextView: UITextView = {
        let tv = UITextView()
        tv.isScrollEnabled = true
        tv.layer.borderWidth = 0.5
        tv.layer.borderColor = UIColor.systemGray.cgColor
        tv.layer.cornerRadius = 5
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    private let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("UPLOAD", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemGray
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    // MARK: - Selectors
    
    @objc func handleCancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func handleUpload(){
        guard let memo = toDoTextView.text else { return }
        
        ToDoService.shared.uploadToDo(memo: memo) { (response) in
            switch response.result{
            case .success(_):
                print(response.result)
                self.delegate?.controller(self)
            case .failure(let error):
                print(error)
            }
        }
        
//        ToDoService.shared.uploadToDo(memo: memo) { (error) in
//            if let error = error{
//                print("DEBUG: error is \(error.localizedDescription)")
//                return
//            }
//
//            self.delegate?.controller(self)
//        }
    }
    
    // MARK: - Helpers
    
    func configureUI(){
        
        view.backgroundColor = .white
        
        toDoTextView.delegate = self
        
        navigationItem.title = "new ToDo"
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleCancel))
        
        view.addSubview(uploadButton)
        uploadButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 16, paddingBottom: 16, paddingRight: 16, height: 48)
        uploadButton.layer.cornerRadius = 6
        
        view.addSubview(toDoTextView)
        toDoTextView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: uploadButton.topAnchor, right: view.rightAnchor,
                            paddingTop: 16, paddingLeft: 16, paddingBottom: 16, paddingRight: 16)
        
        
    }
    
    func checkTextView(){
        if toDoTextView.text.isEmpty{
            uploadButton.isEnabled = false
            uploadButton.backgroundColor = .systemGray
        }else{
            uploadButton.isEnabled = true
            uploadButton.backgroundColor = .systemPurple
        }
    }
    
    
}

// MARK: - UITextViewDelegate

extension UploadToDoController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        checkTextView()
    }
}
