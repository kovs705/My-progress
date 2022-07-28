//
//  ViewController.swift
//  My progress
//
//  Created by Kovs on 29.07.2022.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var progressTV: UITableView!
    var progressObjects: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        progressTV.frame = CGRect(x: 0, y: displayHeight, width: displayWidth, height: displayHeight - barHeight)
        progressTV.register(UITableViewCell.self, forCellReuseIdentifier: "progressCell")
        progressTV.dataSource = self
        progressTV.delegate = self
        
        self.view.addSubview(progressTV)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        progressObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let progress = self.progressObjects[indexPath.row]
        
        let cell = progressTV.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) // as! Swift.file
        // give values here..
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
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


}

