//
//  calendarCell.swift
//  My progress
//
//  Created by Kovs on 01.12.2022.
//

import SwiftUI

struct squareForCalendar: View {
    let color: Color
    
    var body: some View {
        color
            // .frame(width: 10, height: 10)
    }
    
}

struct calendarCell: View {
    var numberOfDays: Int
    var numberOfDaysPassed: Int
    
    var body: some View {
        
        Text("% the number of days, if it's % by 5 so divide it by 5 to have a perfect grid, i guess")
        
    }
}

struct calendarCell_Previews: PreviewProvider {
    static var previews: some View {
        calendarCell(numberOfDays: 30, numberOfDaysPassed: 15)
    }
}
