//
//  progressLayer.swift
//  My progress
//
//  Created by Kovs on 05.08.2022.
//

import UIKit
import CoreData

/// it's a UIView for the first type of progress, it's a circle one, should has a color, value and progress attributes
///
///
///

class circleProgressView: BaseView {
    
    lazy var progress = Progress()
    let circleLayer = CAShapeLayer()
    
    let backView = UIView()
    
    
    override init() {
        super.init() // initialize a new object
        
        let center = backView.center
        
        // configuring..
        backView.backgroundColor = .clear
        
        let circularPathForProgressView = UIBezierPath(arcCenter: center, radius: 37, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        circleLayer.path = circularPathForProgressView.cgPath
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.lineWidth = 9
        
        addSubview(backView)
        backView.layer.addSublayer(circleLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.frame.size = CGSize(width: 60, height: 60)
        backView.frame.origin = CGPoint(x: 30, y: 30)
    }
    
}



class BaseView: UIView {

    // This initializer hides init(frame:) from subclasses
    init() {
        super.init(frame: CGRect.zero)
    }

    // This attribute hides `init(coder:)` from subclasses
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
}
