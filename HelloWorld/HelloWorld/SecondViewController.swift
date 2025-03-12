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
      // SecondViewController가 사라질 때 delegate에게 메시지를 전달
      delegate?.didDismissSecondViewController(message: "Bye!")

    }
    
    func setupUI() {
        print("07 SecondViewController.setupUI()")
        self.view.backgroundColor = .yellow
        
        let label = UILabel()
        label.text = "Second View"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24)
        label.frame = CGRect(x: 20, y: 100, width: view.frame.width - 40, height: 40)
        self.view.addSubview(label)
    }

}
