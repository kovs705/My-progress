//
//  scrollPage.swift
//  My progress
//
//  Created by Kovs on 23.11.2022.
//

import UIKit
import SnapKit

extension UIScrollView {
    
    func makeScrollPage() {
        self.showsVerticalScrollIndicator = true
        self.bounces = true
        self.alwaysBounceVertical = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    func placeScrollPage(view: UIView) {
        self.snp.makeConstraints { (scroll) -> Void in
            scroll.top.equalTo(view.snp.top)
            scroll.leading.equalTo(view.snp.leading)
            scroll.bottom.right.equalTo(view)
        }
    }
    
}
