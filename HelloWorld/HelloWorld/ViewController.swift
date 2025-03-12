//
//  ViewController.swift
//  HelloWorld
//
//  Created by 김동영 on 3/12/25.
//

import UIKit

class ViewController: UIViewController, SecondViewControllerDelegate {
    
    // 컴포넌트 만들 때 많이 쓰는 방법
    // lazy var: 초기화를 늦게 하기 위해 사용하는 키워드
    lazy var myLabel: UILabel = {
        print("myLabel 생성")
        let label = UILabel()
        label.text = "입력 결과를 출력합니다."
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }

  func setupUI() {
    let label = UILabel()
    label.text = "Hello, World!"
    // (content layout) 라벨의 텍스트를 가운데 정렬
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 24)
//    // (frame layout) 붙여질 뷰의 위치와 크기를 설정
//    label.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 40)
      label.translatesAutoresizingMaskIntoConstraints = false
    // self.view(메인 뷰)에 라벨을 서브 뷰로 추가
    view.addSubview(label)
      
      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 200),
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        label.heightAnchor.constraint(equalToConstant: 40),
      ])
      
      let button = UIButton()
      button.setTitle("Go second", for: .normal)
      button.setTitleColor(.blue, for: .normal)
//      button.frame = CGRect(x: 20, y: 200, width: view.frame.width - 40, height: 40)
      button.translatesAutoresizingMaskIntoConstraints = false
      button.addTarget(self, action: #selector(goSecond), for: .touchUpInside)
      view.addSubview(button)
      NSLayoutConstraint.activate([
        button.topAnchor.constraint(equalTo: label.topAnchor, constant: 200),
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        button.heightAnchor.constraint(equalToConstant: 40),
      ])
      
      self.view.addSubview(myLabel)
      NSLayoutConstraint.activate([
        myLabel.topAnchor.constraint(equalTo: button.topAnchor, constant: 200),
        myLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
        myLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
        myLabel.heightAnchor.constraint(equalToConstant: 40),
      ])
  }
    
    func didDismissSecondViewController(message: String) {
        myLabel.text = message
    }
    
    @objc func goSecond() {
        let secondVC = SecondViewController()
        secondVC.delegate = self
        self.present(secondVC, animated: true)
    }
}
