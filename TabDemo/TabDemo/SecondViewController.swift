//
//  SecondViewController.swift
//  TabDemo
//
//  Created by 김동영 on 3/19/25.
//

import UIKit

class SecondViewController: UIViewController {
    
    let dataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.text = "데이터가 없습니다."
        return label
    }()
    private var observer: NSObjectProtocol? // 옵저버 참조 저장
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Second"
        
        setupLabel()
    }
    
    func setupLabel() {
        view.addSubview(dataLabel)
        dataLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dataLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dataLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        observer = NotificationCenter.default.addObserver(forName: DataManager.dataChangedNotification, object: nil, queue: .main) { [weak self] _ in
            self?.updateLabel()
        }
    }
    
    
    
    func updateLabel() {
        if DataManager.shared.data.isEmpty {
            
        } else {
            dataLabel.text = DataManager.shared.data
        }
    }
    
    deinit {
        if let observer = observer {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
}

