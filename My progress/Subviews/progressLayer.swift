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
    let progressLayer = CAShapeLayer()
    
    var startPoint = CGFloat(-Double.pi / 2)
    var endPoint = CGFloat(3 * Double.pi / 2)
    
    let backView = UIView()
    
    let colors: [UIColor] = [UIColor.red, UIColor.black,
                             UIColor.blue, UIColor.purple, UIColor.orange]
    
    override init() {
        super.init() // initialize a new object
        
        let center = backView.center
        
        // configuring..
        backView.backgroundColor = .clear
        
        let circularPathForProgressView = UIBezierPath(arcCenter: center, radius: 35, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        circleLayer.path = circularPathForProgressView.cgPath
        circleLayer.strokeColor = UIColor(named: "Cloud")?.cgColor
        circleLayer.lineWidth = 9
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.strokeEnd = 1.0
        circleLayer.lineCap = .round
        
        progressLayer.path = circularPathForProgressView.cgPath
        progressLayer.strokeColor = colors.randomElement()?.cgColor
        progressLayer.lineWidth = 9
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.strokeEnd = .random(in: 0...1.0)
        circleLayer.lineCap = .butt
        
        
        //TODO: make circle white\black, add values and progress
        
        addSubview(backView)
        backView.layer.addSublayer(circleLayer)
        backView.layer.addSublayer(progressLayer)
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
