//
//  HomeTaskCell.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/13.
//

import UIKit

public class HomeTaskCell: UICollectionViewCell {
    static let identifier: String = "homeTaskCell"
    
    @IBOutlet var taskNameLabel: UILabel!
    @IBOutlet var taskExpectedTimeLabel: UILabel!
    @IBOutlet var categoryColorBar: UIImageView!
    
    // Sub-task 고려해서 수정하기
    @IBOutlet var taskBar: UIImageView!
}
