//
//  ViewController.swift
//  DelegateDemo
//
//  Created by 김동영 on 3/13/25.
//

import UIKit

class MainViewController: UIViewController, CustomViewControllerDelegate {
   override func viewDidLoad() {
     super.viewDidLoad()
 
     setupButton()
   }
    
    func setupButton() {
       let showCustomViewButton = UIButton(type: .system)
       showCustomViewButton.setTitle("커스텀 뷰 보기", for: .normal)
       showCustomViewButton.addAction(UIAction { _ in
         self.showCustomView()
       }, for: .touchUpInside)
       showCustomViewButton.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(showCustomViewButton)
   
       NSLayoutConstraint.activate([
         showCustomViewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
         showCustomViewButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
       ])
     }
    
    private func showCustomView() {
       let customVC = CustomViewController()
       // 중요: 여기서 self를 델리게이트로 설정합니다
       customVC.delegate = self
       present(customVC, animated: true)
     }
    
    // MARK: - CustomViewControllerDelegate
     func didTapButton(withText text: String) {
       print("버튼이 탭되었습니다. 텍스트: \(text)")
     }
   
     func willAppear() {
       print("CustomViewController가 나타날 예정입니다.")
     }
}

