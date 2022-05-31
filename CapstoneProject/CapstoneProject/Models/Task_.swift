//
//  Task_.swift
//  CapstoneProject
//
//  Created by 김승찬 on 2022/05/27.
//

import Foundation

public struct Task_ {
    public var name: String
    public var tag: String
    public var expectedTime: Int
    public var dueDateStr: String
    public var dueTimeStr: String
    public var color: String
    
    public func getDueDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        return dateFormatter.date(from: self.dueDateStr + self.dueTimeStr) ?? Date()
    }
}
