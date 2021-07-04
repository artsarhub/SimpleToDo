//
//  Task.swift
//  SimpleToDo
//
//  Created by Артём on 04.07.2021.
//

import Foundation

protocol TaskProtocol {
    var isCompleted: Bool { get set }
    var name: String { get }
}

class Task: TaskProtocol {
    var isCompleted: Bool = false
    let name: String
    var subtasks: [Task] = []
    
    init(name: String) {
        self.name = name
    }
}
