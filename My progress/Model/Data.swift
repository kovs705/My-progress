//
//  Data.swift
//  My progress
//
//  Created by Kovs on 23.11.2022.
//

import UIKit
import CoreData


// MARK: - CoreData
//func fetchData() {
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return [] }
//    let viewContext       = appDelegate.persistentContainer.viewContext
//    let fetchRequest      = NSFetchRequest<NSManagedObject>(entityName: "Progress")
//    let sort              = NSSortDescriptor(key: "order", ascending: false)
//    fetchRequest.sortDescriptors = [sort]
//    
//    do {
//        progressObjects = try viewContext.fetch(fetchRequest)
//        // sortGroupsByNumber(groups)
////    } catch let error as NSError {
////        print("Couldn't fetch. \(error), \(error.userInfo)")
////    }
////}
//
//
//// MARK: - Calendar and calculating
//
//extension Calendar {
//    func calculateDaysBetween(_ from: Date, and to: Date) -> Double {
//        let fromDate = startOfDay(for: from)
//        let toDate = startOfDay(for: to)
//
//        let numberOfDays = dateComponents([.day], from: fromDate, to: toDate)
//        print("number of days are \(numberOfDays.day! + 1)")
//        return Double(Double(numberOfDays.day!) + 1.0)
//    }
//
////    func calculateHoursBetween(_ from: Date, and to: Date) -> Double {
////        let fromDate = startOfDay(for: from)
////        let toDate = startOfDay(for: to)
////
////        let hoursToEnd = dateComponents([.hour], from: fromDate, to: toDate)
////
////        return Double(hoursToEnd.hour!)
////    }
//}
//
//func calculateForCircle(_ timeToEnd: Double) -> Double {
//    // let end = 1
//    var value: Double = 0.1
//    if timeToEnd <= 9 {
//        print("Time to end is \(timeToEnd)")
//        value = (Double(timeToEnd) / 10)
//        print(value)
//        return value
//    } else if timeToEnd <= 99 {
//        value = (Double(timeToEnd) / 100)
//        print(value)
//        return value
//    } else if timeToEnd <= 999 {
//        value = (Double(timeToEnd) / 1000)
//        print(value)
//        return value
//    } else {
//        print("damn, that's too much...")
//        return value
//    }
//}
//
//func saveProgress(name: String, progressObjects: [NSManagedObject], progressTV: UITableView, userCalendar: Calendar, dateEnd: DateComponents, dateStart: DateComponents) {
//    // code to add a new progress:
//    print("added ")
//
//    var progressObjects = progressObjects
//
//    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
//        return
//    }
//
//    let managedContext = appDelegate.persistentContainer.viewContext
//
//    let entity = NSEntityDescription.entity(forEntityName: "Progress", in: managedContext)!
//
//    let progress = NSManagedObject(entity: entity, insertInto: managedContext)
//
//    progress.setValue(name, forKey: "name")
//    progress.setValue(1, forKey: "value")
//    progress.setValue(0, forKey: "progress")
//    // progress.setValue((progressObjects.count ?? 0) + 1, forKey: "order")
//
//    // MARK: - Date start
//    progress.setValue(userCalendar.startOfDay(for: Date()), forKey: "dateStart")
//    print("start date --------\(progress.value(forKey: "dateStart") ?? dateStart)")
//
//    // MARK: - Date end
//    var dateEndDebug = DateComponents()
//    dateEndDebug.day = 27
//    dateEndDebug.month = 9
//    dateEndDebug.year = 2022
//
//    let endDate: Date = userCalendar.date(from: dateEndDebug)!
//    print("end date -------- \(endDate)")
//
//    progress.setValue(userCalendar.startOfDay(for: endDate), forKey: "dateEnd")
//    print("\(progress.value(forKey: "dateEnd") ?? dateEnd)")
//
//    if progressObjects.isEmpty {
//        progress.setValue(1, forKey: "order")
//    } else {
//        progress.setValue((progressObjects.count) + 1, forKey: "order")
//    }
//
//    do  {
//        progressObjects.insert(progress, at: 0)
//        try managedContext.save()
//        progressTV.reloadData()
//    } catch let error as NSError {
//        print("Could not save. \(error), \(error.userInfo)")
//    }
//}
