//
//  SecondViewController.swift
//  HelloWorld
//
//  Created by 김동영 on 3/12/25.
//

import UIKit

protocol SecondViewControllerDelegate: AnyObject {
    func didDismissSecondViewController(message: String)
    
}
class SecondViewController: UIViewController {
    weak var delegate: SecondViewControllerDelegate?
    
    // 컴포넌트 만들 때 많이 쓰는 방법
    // lazy var: 초기화를 늦게 하기 위해 사용하는 키워드
    lazy var messageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "메시지를 입력하세요."
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      print("2 ViewController.viewWillAppear()")
    }

    override func viewIsAppearing(_ animated: Bool) {
      super.viewIsAppearing(animated)
      print("3 ViewController.viewIsAppearing()")
    }

    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      print("4 ViewController.viewDidAppear()")
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      print("5 ViewController.viewWillDisappear()")
    }

    override func viewDidDisappear(_ animated: Bool) {
      super.viewDidDisappear(animated)
      print("6 ViewController.viewDidDisappear()")
    }
    
    func setupUI() {
        print("07 SecondViewController.setupUI()")
        self.view.backgroundColor = .yellow
        
        let label = UILabel()
        label.text = "Second View"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
//        label.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.heightAnchor.constraint(equalToConstant: 40)
        ])
        
//        messageTextField.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: 40)
        self.view.addSubview(messageTextField)
        NSLayoutConstraint.activate([
            messageTextField.topAnchor.constraint(equalTo: label.topAnchor, constant: 100),
            messageTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            messageTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            messageTextField.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.setTitleColor(.blue, for: .normal)
//        button.frame = CGRect(x: 20, y: 300, width: view.frame.width - 40, height: 40)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addAction(UIAction { [weak self] _ in
            self?.dismiss(animated: true)
            // SecondViewController가 사라질 때 delegate에게 메시지를 전달
            self?.delegate?.didDismissSecondViewController(message: self?.messageTextField.text ?? "")
        }, for: .touchUpInside)
        
        self.view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: messageTextField.topAnchor, constant: 100),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }

}
