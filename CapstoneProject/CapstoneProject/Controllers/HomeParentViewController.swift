//
//  HomeParentViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/16.
//

import UIKit
import XLPagerTabStrip

public class HomeParentViewController: ButtonBarPagerTabStripViewController {
    
    // MARK: - Properties
    public var homeParentView: HomeParentView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeParentView)
    }
    
    let remainingDayLabels: [String] = ["내일까지",
                                        "3일 뒤까지",
                                        "일주일 뒤까지"]
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        self.settings.style.buttonBarItemLeftRightMargin = (self.view.frame.width / 2)
        self.settings.style.buttonBarItemsShouldFillAvailableWidth = false
        super.viewDidLoad()
        setupAddTaskButton()
        
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: TomorrowChildViewController.identifier)
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ThreeDaysChildViewController.identifier)
        let child3 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: ThreeDaysChildViewController.identifier)
        
        return [child1, child2, child3]
    }
    
    private func setupAddTaskButton() {
        // TO-DO
        // Task detailView 만들기
        let action = UIAction { _ in
            guard let addTaskViewController = self.storyboard?.instantiateViewController(withIdentifier: "addTaskViewController") as? AddTaskViewController else { return }
            // 화면 전환 애니메이션 설정
            addTaskViewController.modalTransitionStyle = .coverVertical
            // 전환된 화면이 보여지는 방법 설정 (fullScreen)
            addTaskViewController.modalPresentationStyle = .fullScreen
            self.present(addTaskViewController, animated: true, completion: nil)
        }
        // 커스텀 이미지 적용 후 pointSize 수정
        let image = UIImage(systemName: "plus.circle.fill")
        let pointSize: CGFloat = 40
        
        homeParentView.addTaskButton.setTitle("", for: .normal)
        homeParentView.addTaskButton.addAction(action, for: .touchUpInside)
        homeParentView.addTaskButton.setImage(image, for: .normal)
        homeParentView.addTaskButton.setPreferredSymbolConfiguration(.init(pointSize: pointSize, weight: .regular), forImageIn: .normal)
    }
    
    override public func updateIndicator(for viewController: PagerTabStripViewController, fromIndex: Int, toIndex: Int, withProgressPercentage progressPercentage: CGFloat, indexWasChanged: Bool) {
        super.updateIndicator(for: viewController, fromIndex: fromIndex, toIndex: toIndex, withProgressPercentage: progressPercentage, indexWasChanged: indexWasChanged)
        if progressPercentage == 1, toIndex >= 0 && toIndex < remainingDayLabels.count {
            self.homeParentView.remainingDayLabel.text = self.remainingDayLabels[toIndex]
        }
    }
}
