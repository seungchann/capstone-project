//
//  TaskCell.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/08.
//

import UIKit

public class TaskCell: UICollectionViewCell {
    // TO-DO
    // Xib 오토 레이아웃 적용
    
    static let identifier: String = "taskCell"
    
    @IBOutlet var taskNameLabel: UILabel!
    @IBOutlet var taskExpectedTimeLabel: UILabel!
    @IBOutlet var categoryColorBar: UIImageView!
    
    // Sub-task 고려해서 수정하기
    @IBOutlet var taskBar: UIImageView!

    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setLayout()
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TaskCell", bundle: nil)
    }
    
    func setLayout() {
        self.addSubview(categoryColorBar)
        self.addSubview(taskNameLabel)
        self.addSubview(taskExpectedTimeLabel)
        self.addSubview(taskBar)
        
        let topBottomMargin: CGFloat = 10
        let middleMargin: CGFloat = (self.frame.height - (2 * topBottomMargin) - (taskNameLabel.frame.height + taskExpectedTimeLabel.frame.height + taskBar.frame.height)) / 2
        
        categoryColorBar.translatesAutoresizingMaskIntoConstraints = false
        categoryColorBar.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 30).isActive = true
        categoryColorBar.topAnchor.constraint(equalTo: self.topAnchor, constant: 3).isActive = true
        categoryColorBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 3).isActive = true
        categoryColorBar.widthAnchor.constraint(equalToConstant: 3).isActive = true
        
        taskNameLabel.translatesAutoresizingMaskIntoConstraints = false
        taskNameLabel.leadingAnchor.constraint(equalTo: categoryColorBar.leadingAnchor, constant: 20).isActive = true
        taskNameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: topBottomMargin).isActive = true
        
        taskExpectedTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        taskExpectedTimeLabel.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor, constant: 0).isActive = true
        taskExpectedTimeLabel.topAnchor.constraint(equalTo: taskNameLabel.bottomAnchor, constant: middleMargin).isActive = true
        
        taskBar.translatesAutoresizingMaskIntoConstraints = false
        taskBar.leadingAnchor.constraint(equalTo: taskNameLabel.leadingAnchor, constant: 0).isActive = true
        taskBar.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: topBottomMargin).isActive = true
        taskBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        taskBar.widthAnchor.constraint(equalToConstant: 150).isActive = true
        }
}
