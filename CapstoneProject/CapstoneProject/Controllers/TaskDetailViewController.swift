//
//  TaskDetailViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/31.
//

import UIKit

public class TaskDetailViewController: UIViewController {
    
    enum ButtonStatus {
        case initial
        case start
        case stop
    }
    
    // MARK: - Instance Properties
    public var taskDetailView: TaskDetailView! {
        guard isViewLoaded else { return nil }
        return (view as! TaskDetailView)
    }
    
    var buttonState: ButtonStatus = .initial
    private var timer: Timer!
    private var startTime: Date!
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setStackViewsCorners()
        setupStartTaskButton()
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.taskDetailView.stackThirdView.isHidden = true
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
            switch self.buttonState {
            case .initial:
                self.taskDetailView.startTaskButton.setTitle("일 그만하기", for: .normal)
                self.taskDetailView.stackThirdView.isHidden = false
                
                self.startTime = Date()
                self.timer = Timer.scheduledTimer(timeInterval: 0.001,
                                                  target: self,
                                                  selector: #selector(self.timeUp),
                                                  userInfo: nil,
                                                  repeats: true)
                self.buttonState = .start
                
            case .start:
                self.taskDetailView.startTaskButton.setTitle("돌아가기", for: .normal)
                self.timer.invalidate()
                
            case .stop:
                return
                
            }
            self.taskDetailView.startTaskButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        }
        
        self.taskDetailView.startTaskButton.addAction(action, for: .touchUpInside)
    }
    
    private func setStackViewsCorners() {
        self.taskDetailView.stackFirstView.layer.cornerRadius = 15
        self.taskDetailView.stackSecondView.layer.cornerRadius = 15
        self.taskDetailView.stackThirdView.layer.cornerRadius = 15
    }
    
    @objc private func timeUp() {
        let timeInterval = Date().timeIntervalSince(self.startTime)
        
        let hour = (Int)(fmod(timeInterval/60/60, 12))
        let minute = (Int)(fmod(timeInterval/60, 60))
        let second = (Int)(fmod(timeInterval, 60))
        
        let timeString: String = String(format: "%02d", hour) + " 시간  " + String(format: "%02d", minute) + " 분  " + String(format: "%02d", second) + " 초"
        self.taskDetailView.progressTimeLabel.text = timeString
    }
}
