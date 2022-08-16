//
//  AddProgressVC.swift
//  My progress
//
//  Created by Kovs on 15.08.2022.
//

import UIKit
import SnapKit

class AddProgressVC: UIViewController {
    
    lazy var scrollPage = UIScrollView()
    lazy var stackView = UIStackView()
    // lazy var view = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        stackView.backgroundColor = .gray
        
        scrollPage.showsVerticalScrollIndicator = true
        scrollPage.bounces = true
        scrollPage.alwaysBounceVertical = true
        // scrollPage.contentSize = CGSize(width: Int(self.view.frame.size.width), height: 100)
        
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        
        // MARK: - platform for views:
        view.addSubview(scrollPage)
        scrollPage.addSubview(stackView)
        
        scrollPage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        scrollPage.snp.makeConstraints { (scroll) -> Void in
            scroll.top.equalTo(view.snp.top)
            scroll.leading.equalTo(view.snp.leading)
            scroll.bottom.right.equalTo(view)
        }
        
        stackView.snp.makeConstraints { (stack) -> Void in
            stack.top.equalTo(scrollPage.snp.top)
            stack.leading.equalTo(view.snp.leading).offset(20)
            stack.bottom.equalTo(scrollPage)
            // stack.width.equalTo(scrollPage.snp.width).offset(-40)
            stack.centerX.equalToSuperview()
        }
        
        // self.view = view
        
        // MARK: - stack's pbjects:
        for _ in 0..<1 {
            let circle = UIView()
            circle.translatesAutoresizingMaskIntoConstraints = true
            
            circle.snp.makeConstraints { (circle) -> Void in
                circle.width.equalTo(50)
                circle.height.equalTo(50)
            }
            // circle.heightAnchor.constraint(equalToConstant: 50).isActive = true
            // circle.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            circle.backgroundColor = .white
            circle.layer.cornerRadius = 24
            
            stackView.addArrangedSubview(circle)
        }
        
    }
    
}
