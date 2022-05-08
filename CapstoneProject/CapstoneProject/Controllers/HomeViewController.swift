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
        
        homeView.taskCollectionView.delegate = self
        homeView.taskCollectionView.dataSource = self
        homeView.taskCollectionView.register(TaskCell.nib(), forCellWithReuseIdentifier: TaskCell.identifier)
        
        setupRemainingLabels()
        setupAddTaskButton()
    }
    
    private func setupRemainingLabels() {
        let remainingTime: Int = 10
        homeView.remainingTimeLabel.text = "\(remainingTime) 시간치"
    }
    
    private func setupAddTaskButton() {
        // TO-DO
        // Task detailView 만들기
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

// TO-DO
// cell 당 마진, 크기 조절
// cell 터치 시에 효과 구현
// cell 드래그 앤 드롭 구현
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TaskCell.identifier, for: indexPath) as! TaskCell
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 7)
    }
}
