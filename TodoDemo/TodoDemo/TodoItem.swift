//
//  TodoItem.swift
//  TodoDemo
//
//  Created by 김동영 on 3/21/25.
//

import UIKit
import CoreData

struct TodoItem: Hashable {
    let id: UUID
    let title: String
    let isComplete: Bool
    
    init(title: String, isComplete: Bool) {
        self.id = UUID()
        self.title = title
        self.isComplete = isComplete
    }
    
    init(id: UUID, title: String, isComplete: Bool) {
        self.id = id
        self.title = title
        self.isComplete = isComplete
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TodoItem, rhs: TodoItem) -> Bool {
        return lhs.id == rhs.id
    }
}

extension TodoItem {
    // TodoItem -> TodoItemEntity 변환
    func toManagedObject(in context: NSManagedObjectContext) -> TodoItemEntity {
        let entity = TodoItemEntity(context: context)
        entity.id = id
        entity.title = title
        entity.createdAt = Date()
        entity.isComplete = isComplete
        return entity
    }
    
    // TodoItemEntity -> TodoItem 변환
    static func from(_ entity: TodoItemEntity) -> TodoItem? {
        guard let id = entity.id,
              let title = entity.title else {
            return nil
        }
        let isComplete = entity.isComplete
    
        
        let item = TodoItem(id: id, title: title, isComplete: isComplete)
        return item
    }
    
}
