//
//  progressTVC.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//

import UIKit
import SnapKit
import CoreData

class progressTVC: UITableViewCell {
    
    let progressName = UILabel()
    // progress:
    let progress = UIView()
    
    
    // MARK: - Progress Layer
    
    let circleLayer = CAShapeLayer()
    let progressLayer = CAShapeLayer()
    
    var startPoint = CGFloat(-Double.pi / 2)
    var endPoint = CGFloat(3 * Double.pi / 2)
    
    let backView = UIView()
    let colors: [UIColor] = [UIColor.red, UIColor.black,
                             UIColor.blue, UIColor.purple, UIColor.orange]

    
    let userCalendar = Calendar.current
    
    // MARK: - Init()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(endDate: Date, startDate: Date) -> UITableViewCell {
        
        progressName.translatesAutoresizingMaskIntoConstraints = false
        progress.translatesAutoresizingMaskIntoConstraints = false
        backView.translatesAutoresizingMaskIntoConstraints = false
        
        progressName.font = UIFont.systemFont(ofSize: 20)
        progress.backgroundColor = .clear
        
        // contentView.addSubview(progressName)
        addSubview(progressName)
        addSubview(progress)
        
        // progress.addSubview(circleProgressView(progressObject: progressObject))
        
        progress.snp.makeConstraints { (make) -> Void in
            make.right.equalTo(-20)
            make.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.width.equalTo(60)
            make.height.equalTo(60)
        }
        
        progressName.snp.makeConstraints { (make) -> Void in
            //make.left.equalTo(20)
            // make.height.equalTo(50)
            make.left.top.equalTo(20)
            make.bottom.equalTo(-20)
            make.right.equalTo(progress.snp.left).offset(-20)
        }
        
        progress.backgroundColor = .clear
        
        backView.backgroundColor = .clear
        backView.frame.size = CGSize(width: 60, height: 60)
        backView.frame.origin = CGPoint(x: 0, y: 0)
        
        let circularPathForProgressView = UIBezierPath(arcCenter: CGPoint(x: 30, y: 30), radius: 35, startAngle: startPoint, endAngle: endPoint, clockwise: true)
        
        configureCircleLayer(circleLayer, circularPathForProgressView)
        configureProgressLayer(progressLayer, circularPathForProgressView, colors)
        
        let daysBetween = calculateForCircle(userCalendar.calculateDaysBetween(startDate, and: endDate))
        progressLayer.strokeEnd = daysBetween
        
        progress.addSubview(backView)
        progress.layer.addSublayer(circleLayer)
        progress.layer.addSublayer(progressLayer)
        
        return self
    }


    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

func configureProgressLayer(_ progressLayer: CAShapeLayer, _ circularPathForProgressView: UIBezierPath, _ colors: [UIColor]) {
    progressLayer.path = circularPathForProgressView.cgPath
    progressLayer.strokeColor = colors.randomElement()?.cgColor
    progressLayer.lineWidth = 9
    progressLayer.fillColor = UIColor.clear.cgColor
    
    
    // progressLayer.strokeEnd = .random(in: 0...1.0) //TODO: - work this this one
    // progressLayer.strokeEnd = calculateForCircle(Calendar.current.calculateDaysBetween(progressObject.value(forKey: "dateStart") as! Date, and: Calendar.current.date(from: dateEndDebug)!))
    // progressLayer.strokeEnd = calculateForCircle(userCalendar.calculateDaysBetween(progressStartDate, and: userCalendar.date(from: dateEndDebug)!))
}

func configureCircleLayer(_ circleLayer: CAShapeLayer, _ circularPathForProgressView: UIBezierPath) {
    circleLayer.path = circularPathForProgressView.cgPath
    circleLayer.strokeColor = UIColor(named: "Cloud")?.cgColor
    circleLayer.lineWidth = 9
    circleLayer.fillColor = UIColor.clear.cgColor
    circleLayer.strokeEnd = 1.0
    circleLayer.lineCap = .round
}
