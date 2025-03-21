//
//  TodoTableViewController.swift
//  TodoDemo
//
//  Created by 김동영 on 3/21/25.
//

import UIKit
import CoreData

class TodoTableViewController: UITableViewController {
    
    // MARK: - Properties
    private var items: [TodoItem] = []
    
    private var persistentContainer = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
    
    private var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext  // 일꾼
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(TodoTableViewCell.self, forCellReuseIdentifier: "TodoCell")
        configureNavigation()
        configureTableView()
        configureSearchController()
        
        // 샘플 데이터 추가 버튼
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addNewItem)
        )
        
        // 데이터 로드
        loadTodoItems()
    }
    
    
    func configureNavigation() {
        title = "Todo List"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        tableView.rowHeight = 60
    }
    
    @objc func addNewItem() {
        let alert = UIAlertController(
            title: "새 할 일 입력",
            message: "할 일을 입력하세요.",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = "할 일 입력"
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                let newItem = TodoItem(title: text, isComplete: false)
                self?.saveTodoItem(newItem)
            }
        })
        
        present(alert, animated: true)
        
    }
    
    // 데이터 저장
    private func saveTodoItem(_ item: TodoItem) {
        let _ = item.toManagedObject(in: viewContext)
        
        do {
            try viewContext.save()
            // 저장 후 UI 업데이트
            loadTodoItems()
        } catch {
            print("저장 실패: \(error)")
        }
    }
    
    private func loadTodoItems() {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: "createdAt", ascending: true)]
        do {
            let result = try viewContext.fetch(request)
            items = result.compactMap { TodoItem.from($0) }
            // 테이블 뷰 리로드
            tableView.reloadData()
        } catch {
            print("데이터 로드 실패: \(error)")
        }
    }
    
    private func updateTodoTitle(id: UUID, newTitle: String) {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(request)
            guard let object = result.first else { return }
            
            object.title = newTitle
                        
            try viewContext.save()
            
            // 수정 후 UI 업데이트
            loadTodoItems()
        } catch {
            print("수정 실패: \(error)")
        }
        
    }
    
    private func updateIsComplete(id: UUID, isComplete: Bool) {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", id as CVarArg)
        
        do {
            let result = try viewContext.fetch(request)
            guard let object = result.first else { return }
            
            object.isComplete = isComplete
            try viewContext.save()
            
            // 수정 후 UI 업데이트
            loadTodoItems()
        } catch {
            print("수정 실패: \(error)")
        }
        
    }
    
    // 데이터 삭제
    private func deleteTodoItem(_ item: TodoItem) {
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id = %@", item.id as CVarArg)
        
        do {
            let result = try viewContext.fetch(request)
            guard let object = result.first else { return }
            
            viewContext.delete(object)
            try viewContext.save()
            
            // 삭제 후 UI 업데이트
            loadTodoItems()
        } catch {
            print("삭제 실패: \(error)")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodoCell", for: indexPath) as! TodoTableViewCell
        
        let item = items[indexPath.row]
                
        cell.configure(item: item)

        cell.toggleCompletion = { [weak self] in
            self?.updateIsComplete(id: item.id, isComplete: !item.isComplete)
        }
        
        return cell
    }
    
    // MARK: - 테이블뷰 델리게이트 메서드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items[indexPath.row]
        
        // 확인 알림 표시
        let alert = UIAlertController(
            title: "할 일 수정",
            message: "\(item.title)을(를) 수정합니다.",
            preferredStyle: .alert
        )
        
        alert.addTextField { textField in
            textField.placeholder = item.title
            textField.keyboardType = .default
        }
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "수정", style: .default) { [weak self] _ in
            if let text = alert.textFields?.first?.text, !text.isEmpty {
                self?.updateTodoTitle(id: item.id, newTitle: text)
            }
        })
        
        present(alert, animated: true)
    }
    
    // 스와이프 삭제 기능 구현
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = items[indexPath.row]
            deleteTodoItem(item)
        }
    }
}

// 검색 기능 구현
extension TodoTableViewController: UISearchResultsUpdating {
    
    // 검색 컨트롤러 설정
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "검색"
        navigationItem.searchController = searchController
        
        // 네비게이션 바에 검색바가 숨겨지지 않도록 설정
        navigationItem.hidesSearchBarWhenScrolling = false
        
        // 검색 결과 화면을 현재 뷰 컨트롤러로 설정
        definesPresentationContext = true
    }
    
    // 검색 기능 구현
    func searchGridItems(_ text: String) {
        
        // 검색어가 없을 때 전체 데이터 로드
        if text.isEmpty {
            loadTodoItems()
            return
        }
        
        let request: NSFetchRequest<TodoItemEntity> = TodoItemEntity.fetchRequest()
        
        request.predicate = NSPredicate(format: "title CONTAINS[cd] %@", text)
        
        do {
            let result = try viewContext.fetch(request)
            items = result.compactMap { TodoItem.from($0) }
            tableView.reloadData()
        } catch {
            print("검색 실패: \(error)")
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        searchGridItems(text)
    }
}
