//
//  ViewController.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//

import UIKit
import CoreData
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var progressTV = UITableView()
    lazy var scrollView = UIScrollView()
    let floatingButton = UIButton()
    
    var progressObjects: [NSManagedObject] = []
    let userCalendar = Calendar.current
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Navigation
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(refreshTV))
        self.navigationItem.rightBarButtonItem = refreshButton
        
        title = "My progress"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        
        
        // MARK: - Interface
        view.backgroundColor = .white
        
        /// progressTV.contentSize = self.view.contentSize
        progressTV.makeProgressTV(view: view)
        
        progressTV.dataSource = self
        progressTV.delegate = self
        
        self.view.addSubview(progressTV)
        
        progressTV.placeProgressTV(view: view)
        
        
        // MARK: - Floating button
        floatingButton.makeFloatingButton()

        view.addSubview(floatingButton)
        floatingButton.placeFloatingButton(view: view)
        
        floatingButton.addTarget(self, action: #selector(openVCToAddProgress), for: .touchUpInside)
        
    }
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressObjects.count
    }
    
    
    // MARK: - CellForRowAt
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let progress = self.progressObjects[indexPath.row]
        // let endDate = progress.value(forKey: "dateEnd") as! Date
        
        let cell = progressTV.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! progressTVC
        cell.configureCell(endDate: ((progress.value(forKey: "dateEnd") as? Date) ?? Date()), startDate: ((progress.value(forKey: "dateStart") as? Date) ?? Date()))
        
        // give values here..
        cell.progressName.text = progress.value(forKey: "name") as? String ?? "unknown progress"
        
        print("End date is \(String(describing: progress.value(forKey: "dateEnd")))")
        print("Start date is \(String(describing: progress.value(forKey: "dateStart")))")
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    // MARK: - didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var selectedRow = 0
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        selectedRow = indexPath.row
        print("\(selectedRow)")
    
        managedContext.delete(progressObjects[selectedRow])
        
        for progress in progressObjects {
            if progress.value(forKey: "order") as! Int > progressObjects[selectedRow].value(forKey: "order") as! Int {
                let progressToReduce = progress.value(forKey: "order") as! Int - 1
                progress.setValue(progressToReduce, forKey: "order")
            } else {
                // return
                let progressToReduce = progress.value(forKey: "order") as! Int - 1
                progress.setValue(progressToReduce, forKey: "order")
            }
        }
        // tableView.deselectRow(at: indexPath, animated: true)
        print("row is deleted")
        
        do {
            if managedContext.hasChanges {
                try managedContext.save()
                
                fetchData()
                progressTV.reloadData()
                // fetchData()
            }
        } catch {
            print("Something wrong on deleting the progress")
        }
    }
    
    @objc func openVCToAddProgress(sender: UIButton!) {
        print("Floating button clicked!")
        // self.navigationController?.pushViewController(AddProgressVC(), animated: true)
//         let addProgressViewConrtoller = AddProgressVC()
//         addProgressViewConrtoller.delegate = self
        self.navigationController?.showDetailViewController(AddProgressVC(), sender: sender)
    }
    
    // MARK: - addProgress()
    @objc func addProgress() {
        let alert = UIAlertController(title: "New group", message: "Enter a name for the group", preferredStyle: .alert)
        
        // save action button
        let saveAction = UIAlertAction(title: "Save", style: .default) { [unowned self] action in
            
            guard
                let textField = alert.textFields?.first,
                let textToSave = textField.text
            else {
                return
            }
            
            // saveProgress(name: textToSave, progressObjects: progressObjects, progressTV: progressTV, userCalendar: userCalendar, dateEnd: dateEnd, dateStart: dateStart)
            createNewProgress(name: textToSave, dateEnd: Date(), dateStart: Date())
            
            print(progressObjects.count)
            
            // self.groupCollection.reloadData()
        }
        // cancel action button
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addTextField()
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    // MARK: - Functions
    func saveProgress(name: String) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Progress", in: managedContext)!
        let progress = NSManagedObject(entity: entity, insertInto: managedContext)
        
        progress.setValue(name, forKey: "name")
        progress.setValue(1, forKey: "value")
        progress.setValue(0, forKey: "progress")
        // progress.setValue((progressObjects.count ?? 0) + 1, forKey: "order")
        
        // MARK: - Date start
        progress.setValue(userCalendar.startOfDay(for: Date()), forKey: "dateStart")
        progress.setValue(userCalendar.startOfDay(for: Date()), forKey: "dateEnd")
        // print("\(progress.value(forKey: "dateEnd") ?? dateEnd)")
        
        if progressObjects.isEmpty {
            progress.setValue(1, forKey: "order")
        } else {
            progress.setValue((progressObjects.count) + 1, forKey: "order")
        }
        
        do  {
            progressObjects.insert(progress, at: 0)
            try managedContext.save()
            progressTV.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // MARK: - fetchData()
    func fetchData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let viewContext       = appDelegate.persistentContainer.viewContext
        let fetchRequest      = NSFetchRequest<NSManagedObject>(entityName: "Progress")
        let sort              = NSSortDescriptor(key: "order", ascending: false)
        fetchRequest.sortDescriptors = [sort]

        do {
            progressObjects = try viewContext.fetch(fetchRequest)
            // sortGroupsByNumber(groups)
        } catch let error as NSError {
            print("Couldn't fetch. \(error), \(error.userInfo)")
        }
    }
    
    @objc func refreshTV() {
        fetchData()
        progressTV.reloadData()
    }
    
    
    // MARK: Create a new Progress:
    func createNewProgress(name: String, dateEnd: Date, dateStart: Date) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Progress", in: managedContext)!
        let progress = NSManagedObject(entity: entity, insertInto: managedContext)
        
        progress.setValue(name, forKey: "name")
        progress.setValue(1, forKey: "value")
        progress.setValue(0, forKey: "progress")
        
        progress.setValue(userCalendar.startOfDay(for: dateStart), forKey: "dateStart")
        progress.setValue(userCalendar.startOfDay(for: dateEnd), forKey: "dateEnd")
        
        if progressObjects.isEmpty {
            progress.setValue(1, forKey: "order")
        } else {
            progress.setValue((progressObjects.count) + 1, forKey: "order")
        }
        
        do  {
            progressObjects.insert(progress, at: 0)
            try managedContext.save()
            fetchData()
            progressTV.reloadData()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
}

// MARK: - progress calculating
extension Calendar {
    
    func calculateTimeIntervalSince(start: Date, end: Date) -> Double {
        return end.timeIntervalSince(start)
    }
    
    func calculateDaysBetween(_ from: Date, and to: Date) -> Double {
        let fromDate = startOfDay(for: from)
        let toDate = startOfDay(for: to)

        let numberOfDays = dateComponents([.day], from: fromDate+1, to: toDate+1)
        return Double(Double(numberOfDays.day!))
    }

//    func calculateHoursBetween(_ from: Date, and to: Date) -> Double {
//        let fromDate = startOfDay(for: from)
//        let toDate = startOfDay(for: to)
//
//        let hoursToEnd = dateComponents([.hour], from: fromDate, to: toDate)
//
//        return Double(hoursToEnd.hour!)
//    }
}

func calculateForCircle(_ timeToEnd: Double) -> Double {
    // let end = 1
    var value: Double = 0.1
    if timeToEnd <= 9 {
        print("Time to end is \(timeToEnd)")
        value = (Double(timeToEnd) / 10)
        print(value)
        return value
    } else if timeToEnd <= 99 {
        value = (Double(timeToEnd) / 100)
        print(value)
        return value
    } else if timeToEnd <= 999 {
        value = (Double(timeToEnd) / 1000)
        print(value)
        return value
    } else {
        print("damn, that's too much...")
        return value
    }
}

// MARK: - ScrollView
//        scrollView.bounces                      = true
//        // scrollView.isPagingEnabled = true
//        // scrollView.contentSize                  = CGSize(width: Int(self.view.frame.size.width), height: 100)
//        scrollView.showsVerticalScrollIndicator = false
//        scrollView.contentSize                  = self.view.frame.size
//        scrollView.backgroundColor              = UIColor(named: "DarkBackground")
//
//        scrollView.alwaysBounceVertical = true
//        scrollView.bounces = true
//
//        self.view.addSubview(scrollView)
//        scrollView.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(view.snp.top)
//            make.bottom.left.right.equalTo(view)
//        }

