//
//  TaskListElement.swift
//  Endless task list
//
//  Created by Anton Hodyna on 09/04/2022.
//

import Foundation

class TaskListElement {
    let name: String
    var subtasks: [TaskListElement]
    
    init(name: String, subtasks: [TaskListElement]) {
        self.name = name
        self.subtasks = subtasks
    }
    
    func subtasksCount() -> Int{
        return subtasks.count
    }
    
    func addNewSubtask(task: TaskListElement) {
        subtasks.append(task)
    }
    
}
