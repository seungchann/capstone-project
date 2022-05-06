//
//  Task.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/06.
//

import Foundation
import UIKit

public struct Task {
    public var name: String
    public var tag: String
    public var expectedTime: Int // expectedTime은 x min 형식으로 받아서, "(x/60)시간 (x%60)분 남았습니다." 로 표현
    public var dueDate: DateComponents
    public var color: UIColor
    public var subTaskList: [SubTask]
    
    func getTaskExpectedTime() -> Int {
        var result: Int = 0
        self.subTaskList.forEach { result += $0.expectedTime }
        return result
    }
}

public struct SubTask {
    // name, color는 미정
    public var name: String?
    public var color: UIColor?
    public var expectedTime: Int
}
