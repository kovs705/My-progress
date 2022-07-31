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
    var progressObjects: [NSManagedObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Navigation
        let addProgressBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addProgress))
        self.navigationItem.rightBarButtonItem = addProgressBarButton
        
        fetchData()
        
        
        // MARK: - Interface
        
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        progressTV = UITableView()
        progressTV.backgroundView?.backgroundColor = .black
        progressTV.backgroundColor = .black
        progressTV.frame = CGRect(x: 0, y: displayHeight, width: displayWidth, height: displayHeight - barHeight)
        progressTV.register(progressTVC.self, forCellReuseIdentifier: "progressCell")
        progressTV.rowHeight = 150
        // progressTV.tableFooterView = UIView()
        
        progressTV.dataSource = self
        progressTV.delegate = self
        
        self.view.addSubview(progressTV)
        
    }
    
    
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        progressObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let progress = self.progressObjects[indexPath.row]
        
        let cell = progressTV.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! progressTVC
        // give values here..
        cell.progressName.text = progress.value(forKey: "name") as? String ?? "unknown progress"
        
        cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - Functions
    @objc func addProgress() {
        // code to add a new progress:
        
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

