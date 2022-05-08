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
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "TaskCell", bundle: nil)
    }
}
