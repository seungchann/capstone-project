//
//  HomeChildViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/08.
//

import UIKit
import XLPagerTabStrip
import CoreData

public class TomorrowChildViewController: UIViewController {
    
    static let identifier: String = "tomorrowChildViewController"
    
    // MARK: - Instance Properties
    public var homeChildView: HomeChildView! {
        guard isViewLoaded else { return nil }
        return (view as! HomeChildView)
    }
    
    let request: NSFetchRequest<Task> = Task.fetchRequest()
    var taskList: [Task] = []
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        homeChildView.taskCollectionView.delegate = self
        homeChildView.taskCollectionView.dataSource = self
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.taskList = PersistenceManager.shared.fetch(request: request)
        
        // For Debugging
        taskList.flatMap {
            print($0.name)
            print($0.color)
            print($0.expectedTime)
        }
        
        self.homeChildView.taskCollectionView.reloadData()
    }
}

// TO-DO
// cell 당 마진, 크기 조절
// cell 터치 시에 효과 구현
// cell 드래그 앤 드롭 구현
extension TomorrowChildViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskList.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeTaskCell.identifier, for: indexPath) as! HomeTaskCell
       
        cell.taskBar.layer.cornerRadius = 8
        cell.taskBar.backgroundColor = UIColor(rgb: Int(self.taskList[indexPath.row].color))
        cell.taskNameLabel.text = self.taskList[indexPath.row].name
        
        
        var expectedMin =  Int(self.taskList[indexPath.row].expectedTime)
        var expectedHour = 0
        if expectedMin > 60 {
            expectedHour = Int(floor(Double(expectedMin / 60)))
            expectedMin -= (expectedHour * 60)
            cell.taskExpectedTimeLabel.text = "\(expectedHour)시간 \(expectedMin) 분"
        } else {
            cell.taskExpectedTimeLabel.text = "\(expectedMin) 분"
        }
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 90)
    }
}

extension TomorrowChildViewController: IndicatorInfoProvider {
    public func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return ""
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, a: Int = 0xFF) {
        self.init(
            red: CGFloat(red) / 255.0,
            green: CGFloat(green) / 255.0,
            blue: CGFloat(blue) / 255.0,
            alpha: CGFloat(a) / 25.0
        )
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 16) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    convenience init(argb: Int) {
        self.init(
            red: (argb >> 16) & 0xFF,
            green: (argb >> 16) & 0xFF,
            blue: argb & 0xFF,
            a: (argb >> 24) & 0xFF
        )
    }
}
