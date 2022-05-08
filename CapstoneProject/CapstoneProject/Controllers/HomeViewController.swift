//
//  HomeViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/08.
//

import UIKit

public class HomeViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var homeView: HomeView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeView)
    }
    
    // MARK - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupRemainingLabels()
        setupAddTaskButton()
    }
    
    private func setupRemainingLabels() {
        let remainingTime: Int = 10
        homeView.remainingTimeLabel.text = "\(remainingTime) 시간치"
    }
    
    private func setupAddTaskButton() {
        let action = UIAction { _ in
            print("!!!!AddTask!!!")
        }
        // 커스텀 이미지 적용 후 pointSize 수정
        let image = UIImage(systemName: "plus.circle.fill")
        let pointSize: CGFloat = 40
        
        homeView.addTaskButton.setTitle("", for: .normal)
        homeView.addTaskButton.addAction(action, for: .touchUpInside)
        homeView.addTaskButton.setImage(image, for: .normal)
        homeView.addTaskButton.setPreferredSymbolConfiguration(.init(pointSize: pointSize, weight: .regular), forImageIn: .normal)
    }
}
