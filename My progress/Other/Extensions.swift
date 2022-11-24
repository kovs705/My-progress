//
//  Extensions.swift
//  My progress
//
//  Created by Kovs on 07.08.2022.
//

import SwiftUI

extension Color {
    static let backWhite = Color("BackWhite")
    static let cloud = Color("Cloud")
}

func returnColorFromString(nameOfColor: String) -> Color {
    return Color.init(nameOfColor)
}
// #warning("work on it") --> completed
func returnUIColorFromString(string: String) -> UIColor? {
    // return UIColor.init(Color.init(string))
    return UIColor(named: string)
}
