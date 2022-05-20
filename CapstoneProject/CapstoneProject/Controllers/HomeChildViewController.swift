//
//  HomeChildViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/08.
//

import UIKit
import XLPagerTabStrip

public class HomeChildViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var homeChildView: HomeChildView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeChildView)
    }
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        homeChildView.taskCollectionView.delegate = self
        homeChildView.taskCollectionView.dataSource = self
        
        setupRemainingLabels()
    }
    
    private func setupRemainingLabels() {
        let remainingTime: Int = 10
        homeChildView.remainingTimeLabel.text = "\(remainingTime) 시간치"
    }
    
}

// TO-DO
// cell 당 마진, 크기 조절
// cell 터치 시에 효과 구현
// cell 드래그 앤 드롭 구현
extension HomeChildViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTaskCell.identifier, for: indexPath) as! HomeTaskCell
       
        cell.taskNameLabel.text = "Example Task"
        cell.taskExpectedTimeLabel.text = "O 시간"
        
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: self.view.bounds.height / 6)
    }
}

extension HomeChildViewController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return "TEST"
    }
}
