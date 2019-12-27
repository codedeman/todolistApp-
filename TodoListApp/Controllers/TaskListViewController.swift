//
//  TaskListViewController.swift
//  TodoListApp
//
//  Created by KIENPT6 on 12/13/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController {

    

    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    private var tasks = BehaviorRelay<[Task]>(value: [])
    private var filteredTasks = [Task]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func addNewTaskButton(_ sender: Any) {
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navC = segue.destination as? UINavigationController,
                   let addTVC = navC.viewControllers.first as? AddTaskViewController else {
                       fatalError("Controller not found...")
               }
        addTVC.taskSubjectObservable.subscribe(onNext: { [unowned self]  (task) in
            
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            var existingTasks = self.tasks.value
            existingTasks.append(task)
            self.tasks.accept(existingTasks)
            
            self.filterTasks(by: priority)
            
            }).disposed(by: disposeBag)
        
    }
    
    
    @IBAction func priorityChanged(segmentedControl:UISegmentedControl){
    
        
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        
        filterTasks(by: priority)
//        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
//        filterTasks(by: priority)
    }
    private func filterTasks(by priority:Priority?){
    
        if  priority == nil {
            
            self.filteredTasks = self.tasks.value
        }else {
            
            
            self.tasks.map { tasks in
                return tasks.filter { $0.priority == priority! }
            }.subscribe(onNext: { [weak self] (tasks) in
                
                self?.filteredTasks = tasks
                print("task \(tasks)")
                self?.updateTableView()
                
            }).disposed(by: disposeBag)
            
        }
    
        
    }

}


extension TaskListViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell") 
        cell?.textLabel?.text = self.filteredTasks[indexPath.row].title
        
        return cell!
    }

    func updateTableView()   {
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
    }
    


}

