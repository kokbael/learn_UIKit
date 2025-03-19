//
//  ViewController.swift
//  NavigationDemo
//
//  Created by 김동영 on 3/18/25.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "네비게이션 타이틀"
        
        //        // iOS 15 이상에서는 UINavigationBarAppearance() 사용
        //        let appearance = UINavigationBarAppearance()
        //        // 투명한 배경 설정
        //        appearance.configureWithOpaqueBackground()
        //        // 배경색 설정
        //        appearance.backgroundColor = .systemBlue
        //        // 타이틀 색상
        //        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        //        
        //        // 네비게이션 바에 적용 (평상시)
        //        self.navigationController?.navigationBar.standardAppearance = appearance
        //        // 스와이프로 스크롤할 때
        //        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        //        self.navigationController?.navigationBar.tintColor = .white // 아이템 색상
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .blue
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]
        //        self.navigationController?.navigationBar.prefersLargeTitles = true
        //        self.navigationController?.navigationBar.backgroundColor = .systemGray
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let VC = UIViewController()
        VC.view.backgroundColor = .yellow
        VC.title = "서브 타이틀"
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: ViewController())
}
