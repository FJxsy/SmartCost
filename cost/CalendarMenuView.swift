//
//  CalendarMenuView.swift
//  calendar
//
//  Created by 郭振永 on 15/5/6.
//  Copyright (c) 2015年 guozy. All rights reserved.
//

import UIKit

class CalendarMenuView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var weekDayName = ["SUN", "MON", "TUE", "WED", "THU", "FRI", "SAT"]
    var padding: CGFloat = 0.0
    var labelFont: UIFont = UIFont.boldSystemFont(ofSize: 10)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initDayLabel()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initDayLabel() {
        let height = frame.height
        let width = (frame.width - padding * 6) / 7
        var rect = CGRect(x: 0, y: 0, width: width, height: height)
        
        for (index, name) in  weekDayName.enumerated() {
            rect.origin.x =  CGFloat(index) * (width + padding)
            let label = UILabel(frame: rect)
            label.text = name
            label.textAlignment = .center
            label.textColor = UIColor.darkGray
            label.font = labelFont
            addSubview(label)
        }
    }
    
    

}
