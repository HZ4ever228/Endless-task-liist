//
//  TaskListElement.swift
//  Endless task list
//
//  Created by Anton Hodyna on 09/04/2022.
//

import Foundation

protocol Task {
    var name: String {get}
}

class TaskListElement: Task {
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
    
    func updateTasksSubtask(subtask: TaskListElement) {
        for task in subtasks {
            if task.name == subtask.name {
                task.subtasks = subtask.subtasks
            }
        }
    }
    
}
