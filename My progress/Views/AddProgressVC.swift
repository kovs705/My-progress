//
//  AddProgressVC.swift
//  My progress
//
//  Created by Kovs on 15.08.2022.
//

import UIKit
import SnapKit

class AddProgressVC: ViewController {
    
    lazy var scrollPage: UIScrollView = {
        let scrollPage = UIScrollView()
        scrollPage.addSubview(stackView)
        scrollPage.showsVerticalScrollIndicator = true
        scrollPage.bounces = true
        scrollPage.alwaysBounceVertical = true
        scrollPage.contentSize = CGSize(width: Int(self.view.frame.size.width), height: 100)
        return scrollView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    override func loadView() {
        
        let view = UIView()
        view.backgroundColor = .white
        stackView.backgroundColor = .gray
        
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
            stack.leading.equalTo(scrollPage.snp.leading)
            stack.bottom.right.equalTo(scrollPage)
        }
        
        self.view = view
        
        // MARK: - stack's pbjects:
        for _ in 0..<20 {
            let circle = UIView()
            circle.translatesAutoresizingMaskIntoConstraints = true
            circle.snp.makeConstraints { (circle) -> Void in
                circle.width.equalTo(50)
                circle.height.equalTo(50)
            }
            circle.backgroundColor = .gray
            circle.layer.cornerRadius = 24
            
            stackView.addArrangedSubview(circle)
        }
        
    }
    
}
