//
//  TasksViewController.swift
//  Endless task list
//
//  Created by Anton Hodyna on 09/04/2022.
//

import UIKit

protocol PassUpadatedTask {
    func passUpdatedSubtask(subtask: TaskListElement?)
}

class TasksViewController: UIViewController {
    
    public var delegate: PassUpadatedTask?
    
    //MARK: - Outlets

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            self.tableView.delegate = self
            self.tableView.dataSource = self
        }
    }
    @IBOutlet weak var addNewSubtaskStackView: UIStackView! {
        didSet {
            addNewSubtaskStackView.isHidden = true
        }
    }
    @IBOutlet weak var subtaskNameTextField: UITextField! {
        didSet {
            self.subtaskNameTextField.delegate = self
        }
    }
    
    //MARK: - Private Properties
    
    private var task: TaskListElement?
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        if task == nil {
            task = TaskListElement(name: "ParentTask", subtasks: [])
            self.tableView.reloadData()
        }
    }
    
    //MARK: - Actions
    
    @IBAction func addSubtaskButtonAction(_ sender: Any) {
        guard let task = task else { return }
        if subtaskNameTextField.text != nil, let text = subtaskNameTextField.text, !text.isEmpty {
            subtaskNameTextField.isSelected = false
            addNewSubtaskStackView.isHidden = true
            let subtask = TaskListElement(name: text, subtasks: [])
            task.addNewSubtask(task: subtask)
            subtaskNameTextField.text = nil
            self.tableView.reloadData()
        } else {
            print("subtusk name is empty")
        }
        
        
    }
    
    //MARK: - Private functions
    
    private func configureNavigationController() {
        if task != nil {
            title = task?.name
            
            let button = UIButton()
            button.setTitle(" Назад", for: .normal)
            button.addTarget(self, action: #selector(backButtonActionTap), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
            
        let addNewQuestionButton = UIButton(frame: CGRect(x: 0, y: 0, width: 21, height: 21))
        addNewQuestionButton.addTarget(self, action: #selector(addNewSubtaskTaskButtonTap), for: UIControl.Event.touchUpInside)
        addNewQuestionButton.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        let addNewQuestionItem = UIBarButtonItem(customView: addNewQuestionButton)
        navigationItem.setRightBarButtonItems([addNewQuestionItem], animated: true)
        
        
    }
    
    //MARK: - @objc Private functions
    
    @objc private func backButtonActionTap() {
        delegate?.passUpdatedSubtask(subtask: task)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func addNewSubtaskTaskButtonTap() {
        addNewSubtaskStackView.isHidden = !addNewSubtaskStackView.isHidden
    }

}

// MARK: -

extension TasksViewController: UITextFieldDelegate {
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource

extension TasksViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let task = task else {return 0}
        return task.subtasksCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: TaskViewCell.reuseIdentifier, for: indexPath) as? TaskViewCell, let task = task {
            let subtask = task.subtasks[indexPath.row]
            cell.configure(subtask: subtask)
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let subtask = task?.subtasks[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tasksViewController: TasksViewController = storyboard.instantiateViewController(withIdentifier: "TasksViewController") as! TasksViewController
            tasksViewController.task = subtask
            tasksViewController.delegate = self
            self.navigationController?.pushViewController(tasksViewController, animated: true)
        }
        
    }
}

//MARK: - PassUpadatedTask

extension TasksViewController: PassUpadatedTask {
    func passUpdatedSubtask(subtask: TaskListElement?) {
        guard let subtask = subtask, let task = task else { return }
        task.updateTasksSubtask(subtask: subtask)
        self.tableView.reloadData()
    }
}

