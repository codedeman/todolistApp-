//
//  AddTaskViewController.swift
//  TodoListApp
//
//  Created by KIENPT6 on 12/13/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import UIKit

import RxSwift

import RxCocoa
class AddTaskViewController: UIViewController {
    
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField:UITextField!

    private let taskSubject = PublishSubject<Task>()
    
    private let taskString = BehaviorSubject<String>(value: "")
    
    
    
    var taskSubjectObservable: Observable<Task> {
        return taskSubject.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    @IBAction func saveBtnWasPressed(_ sender: Any) {
        
        
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex),
                    let title = self.taskTitleTextField.text else {
                    return
                }
                
        
        let task = Task(title: title, priority: priority)
        
        taskSubject.onNext(task)
        

        
//        taskSubjectObservable.subscribe(onNext: { (task) in
//            
//            print("what the hell \(task)")
//            }, onError: nil, onCompleted: nil)
        
//        taskSubjectObservable.subscribe(onNext: { (task) in
//
//            print("what the hell \(task)")
//            }, onError: nil, onCompleted: nil).dispose()
        
//        self.dismiss(animated: true, completion: nil)
                
//                let task = Task(title: title, priority: priority)
//
//                taskSubject.onNext(task)
//        
                self.dismiss(animated: true, completion: nil)
//        
        
    }
    
    
}
