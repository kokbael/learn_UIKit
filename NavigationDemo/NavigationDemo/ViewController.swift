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
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.tintColor = .blue
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.barTintColor = .systemBlue
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.blue]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let VC = SecondViewController()
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}

#Preview {
    UINavigationController(rootViewController: ViewController())
}
