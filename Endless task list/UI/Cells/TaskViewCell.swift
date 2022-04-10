//
//  TaskViewCell.swift
//  Endless task list
//
//  Created by Anton Hodyna on 09/04/2022.
//

import UIKit

class TaskViewCell: UITableViewCell {
    
    static let reuseIdentifier = "reuseIdentifierTaskViewCell"

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var taskCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clearCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func configure(subtask: TaskListElement) {
        taskNameLabel.text = subtask.name
        taskCountLabel.text = "\(subtask.subtasksCount())"
    }
    
    func clearCell() {
        taskNameLabel.text = ""
        taskCountLabel.text = ""
    }

}
