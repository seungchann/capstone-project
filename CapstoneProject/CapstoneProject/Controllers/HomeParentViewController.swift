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
    @IBOutlet var addTaskButton: UIButton!
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupAddTaskButton()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeChildViewController")
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeChildViewController")
        
        return [child1, child2]
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
        
        self.addTaskButton.setTitle("", for: .normal)
        self.addTaskButton.addAction(action, for: .touchUpInside)
        self.addTaskButton.setImage(image, for: .normal)
        self.addTaskButton.setPreferredSymbolConfiguration(.init(pointSize: pointSize, weight: .regular), forImageIn: .normal)
    }
}
