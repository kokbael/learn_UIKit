//
//  ViewController.swift
//  TableViewDemo
//
//  Created by 김동영 on 3/19/25.
//
// UIView 를 UITableView 처럼 만드는 과정
import UIKit

struct Animal {
    let name: String
    let image: UIImage
}

struct AnimalCategory {
    let category: String
    let animals: [Animal]
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let categories = [
        AnimalCategory(category: "포유류", animals: [
            Animal(name: "사자", image: UIImage(systemName: "circle")!),
            Animal(name: "호랑이", image: UIImage(systemName: "circle")!),
            Animal(name: "곰", image: UIImage(systemName: "circle")!)
        ]),
        AnimalCategory(category: "조류", animals: [
            Animal(name: "독수리", image: UIImage(systemName: "circle.fill")!),
            Animal(name: "부엉이", image: UIImage(systemName: "circle.fill")!),
            Animal(name: "참새", image: UIImage(systemName: "circle.fill")!)
        ]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        
        // 테이블 뷰의 데이터 소스를 현재 뷰 컨트롤러로 설정
        tableView.dataSource = self
        tableView.delegate = self
        
        // 커스텀 셀을 등록
        tableView.register(CustomCell.self, forCellReuseIdentifier: "CustomCell")
        
        view.addSubview(tableView)
    }
    
    // MARK: - UITableViewDataSource
    // 섹션에 포함된 행의 개수를 반환하는 메서드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].animals.count
    }
    
    // 셀을 생성하고 구성하는 메서드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 셀을 재사용 큐에서 가져옴 (as! 에 강제 언래핑은 register로 커스텀 셀을 등록했으므로 문제될 것 없음)
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let animal = categories[indexPath.section].animals[indexPath.row]
        
        cell.configure(image: animal.image, name: animal.name)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    // 섹션의 개수를 반환하는 메서드
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    // 행이 선택되었을 때 호출
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("선택된 행: \(indexPath.row)")
    }
    
    // 행의 높이를 반환
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    //    // 행이 그려지기 직전에 호출
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        cell.backgroundColor = indexPath.row % 2 == 0 ? .systemBackground : .secondarySystemBackground
    //    }
    
    //헤더 뷰를 반환
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].category
    }
}

#Preview {
    UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
}
