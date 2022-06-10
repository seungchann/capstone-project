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
    public var tempTask: Task!
    
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setStackViewsCorners()
        setupLabels()
        setupBackButton()
        setupStartTaskButton()
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.taskDetailView.stackThirdView.isHidden = true
    }
    
    private func setupLabels() {
        self.taskDetailView.taskNameLabel.text = tempTask.name
        
        var expectedMin = Int(self.tempTask.expectedTime)
        var expectedHour: Int = 0
        
        if expectedMin > 60 {
            expectedHour = Int(floor(Double(expectedMin / 60)))
            expectedMin -= (expectedHour * 60)
            if expectedMin == 0 {
                self.taskDetailView.expectedTimeLabel.text = "\(expectedHour)시간"
            } else {
                self.taskDetailView.expectedTimeLabel.text = "\(expectedHour)시간 \(expectedMin) 분"
            }
            
        } else {
            self.taskDetailView.expectedTimeLabel.text = "\(expectedMin) 분"
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko-KR")
        
        // View에 표현
        formatter.dateFormat = "yyyy년 MM월 dd일"
        self.taskDetailView.dueDateLabel.text = formatter.string(from: self.tempTask.dueDate ?? Date())
        
        formatter.dateFormat = "a hh시 mm분"
        self.taskDetailView.dueTimeLable.text = formatter.string(from: self.tempTask.dueDate ?? Date())
        
    }
    
    private func setupBackButton() {
        let action = UIAction { _ in
            self.presentingViewController?.dismiss(animated: true)
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
                self.buttonState = .stop
                
            case .stop:
                self.presentingViewController?.dismiss(animated: true)
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
