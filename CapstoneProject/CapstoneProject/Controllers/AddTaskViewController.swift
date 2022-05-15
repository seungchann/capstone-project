//
//  AddTaskViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/15.
//

import UIKit

public class AddTaskViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var addTaskView: AddTaskView! {
        guard isViewLoaded else { return nil }
        return (view as! AddTaskView)
    }
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBackButton()
        setupAddTaskButton()
    }
    
    // TextField에서 다른 화면 터치 시, 키보드 dismiss.
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.addTaskView.endEditing(true)
    }
    
    private func setupBackButton() {
        let action = UIAction { _ in
            self.presentingViewController?.dismiss(animated: true)
        }
        self.addTaskView.backButton.addAction(action, for: .touchUpInside)
    }
    
    private func setupAddTaskButton() {
        let action = UIAction { _ in
            // TO-DO: 새로운 task 생성 후 HomeViewController로 넘겨주기
            self.presentingViewController?.dismiss(animated: true)
        }
        self.addTaskView.addTaskButton.addAction(action, for: .touchUpInside)
    }
}
