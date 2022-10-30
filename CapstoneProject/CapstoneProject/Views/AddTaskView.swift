//
//  AddTaskView.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/15.
//

import UIKit

public class AddTaskView: UIView {
    @IBOutlet public var backButton: UIButton!
    @IBOutlet public var taskNameTextField: UITextField!
    @IBOutlet public var addTaskButton: UIButton!
    @IBOutlet public var stackFirstView: UIView!
    @IBOutlet public var stackSecondView: UIView!
    @IBOutlet public var dateTextField: UITextField!
    @IBOutlet public var timeTextField: UITextField!
    @IBOutlet public var expectedTimeTextField: UITextField!
    
    // Tag Button 관련 변수
    
    @IBOutlet public var assignButton: UIButton!
    @IBOutlet public var assignBtnBgImageView: UIImageView!
    @IBOutlet public var assignBtnCheckBoxImageView: UIImageView!
    
    @IBOutlet public var projectButton: UIButton!
    @IBOutlet public var projectBtnBgImageView: UIImageView!
    @IBOutlet public var projectBtnCheckBoxImageView: UIImageView!
    
    @IBOutlet public var examButton: UIButton!
    @IBOutlet public var examBtnBgImageView: UIImageView!
    @IBOutlet public var examBtnCheckBoxImageView: UIImageView!
    
    @IBOutlet public var quizButton: UIButton!
    @IBOutlet public var quizBtnBgImageView: UIImageView!
    @IBOutlet public var quizBtnCheckBoxImageView: UIImageView!
    
    @IBOutlet public var presentationButton: UIButton!
    @IBOutlet public var presentationBtnBgImageView: UIImageView!
    @IBOutlet public var presentationCheckBoxImageView: UIImageView!
    
}
