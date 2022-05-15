//
//  TaskDetailViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/15.
//

import UIKit

public class TaskDetailViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var taskDetailView: TaskDetailView! {
        guard isViewLoaded else { return nil }
        return (view as! TaskDetailView)
    }
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // TextField에서 다른 화면 터치 시, 키보드 dismiss.
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.taskDetailView.endEditing(true)
    }
}
