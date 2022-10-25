//
//  CreateTodoController.swift
//  FireBaseToDo
//
//  Created by darkhan on 24.10.2022.
//

import UIKit

class CreateTodoController: UIViewController{
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 28)
        label.textColor = .white
        label.text = "Create a new todo item"
        
        label.textAlignment = .center
        
        return label
    }()
    
    
    private let itemTextField: UITextField = {
        let tf = TextField()
        tf.font = .systemFont(ofSize: 24)
        tf.textColor = .black
        tf.backgroundColor = .white
        tf.layer.cornerRadius = 10
        tf.placeholder = "Enter a new task..."
        tf.tintColor = .systemGreen
        return tf
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle( "Create item", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemGreen
        
        button.addTarget(self, action: #selector(createItemPressed), for: .touchUpInside)
        
        button.layer.cornerRadius = 10
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    @objc func createItemPressed() {
        guard let todoText = itemTextField.text else { return }
        PostService.shared.uploadTodoItem(text: todoText){ (err, ref) in
            self.itemTextField.text = ""
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    func configureUI(){
        view.backgroundColor = UIColor(red: 20/255, green: 33/255, blue: 61/255, alpha: 1.0 )
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(itemTextField)
        itemTextField.anchor(top: titleLabel.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 128, paddingLeft: 16, paddingRight: 16, height: 40)
        itemTextField.delegate = self
        
        view.addSubview(createButton)
        createButton.anchor(left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingLeft: 32, paddingBottom: 32, paddingRight: 32, height: 50)
    }
}

extension CreateTodoController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

class TextField: UITextField {
    let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
