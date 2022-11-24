//
//  progressTV.swift
//  My progress
//
//  Created by Kovs on 23.11.2022.
//

import UIKit
import SnapKit

extension UITableView {
    
    func makeProgressTV(view: UIView) {
        self.contentSize = view.frame.size
        self.register(progressTVC.self, forCellReuseIdentifier: "progressCell")
        self.rowHeight = 100
        self.tableFooterView = UIView()
        
        self.bounces = true
        self.isScrollEnabled = true
        self.alwaysBounceVertical = true
    }
    
    func placeProgressTV(view: UIView) {
        self.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            // make.bottom.left.right.equalTo(view)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}
