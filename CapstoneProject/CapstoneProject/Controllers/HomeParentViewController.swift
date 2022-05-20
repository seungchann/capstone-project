//
//  HomeParentViewController.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/16.
//

import UIKit
import XLPagerTabStrip

public class HomeParentViewController: ButtonBarPagerTabStripViewController {
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override public func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let child1 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeChildViewController")
        let child2 = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeChildViewController")
        
        return [child1, child2]
    }
}
