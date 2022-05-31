//
//  TaskDetailViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/31.
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
        setStackViewsCorners()
        setupStartTaskButton()
    }
    
    private func setupBackButton() {
        let action = UIAction { _ in
            // 뒤로가기 연결
            return
        }
        self.taskDetailView.backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupStartTaskButton() {
        self.taskDetailView.startTaskButton.layer.cornerRadius = 7
        let action = UIAction { _ in
            if self.taskDetailView.startTaskButton.titleLabel?.text == "일 시작하기" {
                self.taskDetailView.startTaskButton.setTitle("일 그만하기", for: .normal)
            } else {
                self.taskDetailView.startTaskButton.setTitle("기록하기", for: .normal)
            }
            self.taskDetailView.startTaskButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        
        self.taskDetailView.startTaskButton.addAction(action, for: .touchUpInside)
    }
    
    private func setStackViewsCorners() {
        self.taskDetailView.stackFirstView.layer.cornerRadius = 15
        self.taskDetailView.stackSecondView.layer.cornerRadius = 15
    }
}
