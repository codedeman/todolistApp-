//
//  Task.swift
//  TodoListApp
//
//  Created by KIENPT6 on 12/13/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import Foundation

enum Priority: Int {
    case high
    case medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}
