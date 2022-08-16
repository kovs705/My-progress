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
    
    // let addProgressVC = AddProgressVC()
    
    lazy var progressTV = UITableView()
    lazy var scrollView = UIScrollView()
    let floatingButton = UIButton()
    
    var progressObjects: [NSManagedObject] = []
    let userCalendar = Calendar.current
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: - Navigation
        let addProgressBarButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addProgress))
        self.navigationItem.rightBarButtonItem = addProgressBarButton
        
        title = "My progress"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        fetchData()
        
        
        // MARK: - Interface
        
        // let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        // let displayWidth: CGFloat = self.view.frame.width
        // let displayHeight: CGFloat = self.view.frame.height
        
        // progressTV = UITableView()
        
        view.backgroundColor = .white
        
        // progressTV.contentSize = self.view.contentSize
        progressTV.contentSize = self.view.frame.size
        progressTV.register(progressTVC.self, forCellReuseIdentifier: "progressCell")
        progressTV.rowHeight = 100
        progressTV.tableFooterView = UIView()
        
        progressTV.bounces = true
        progressTV.isScrollEnabled = true
        progressTV.alwaysBounceVertical = true
        
        progressTV.dataSource = self
        progressTV.delegate = self
        
        self.view.addSubview(progressTV)
        
        progressTV.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(view.snp.top)
            // make.bottom.left.right.equalTo(view)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
        
        // MARK: - Floating button
        
        floatingButton.setTitle("Add", for: .normal)
        floatingButton.backgroundColor = .black
        floatingButton.layer.cornerRadius = 25

        view.addSubview(floatingButton)
        floatingButton.translatesAutoresizingMaskIntoConstraints = false

        floatingButton.snp.makeConstraints { (button) -> Void in
            button.width.equalTo(55)
            button.height.equalTo(55)
            // button.centerX.equalTo(view.snp.centerX)
            button.bottom.equalTo(view.snp.bottom).offset(-30)
            button.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        floatingButton.addTarget(self, action: #selector(openVCToAddProgress), for: .touchUpInside)
        
        print("\(progressObjects.count)")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchData()
        progressTV.reloadData()
    }
    
    
    
    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return progressObjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let progress = self.progressObjects[indexPath.row]
        
        let cell = progressTV.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath) as! progressTVC
        // give values here..
        cell.progressName.text = progress.value(forKey: "name") as? String ?? "unknown progress"
        
        print("\(progress.value(forKey: "name") as? String ?? "Unknown progress name")")
        // print("\(progress.value(forKey: "order") as? String ?? "Unknown order of the progress")")
        
        // cell.contentView.translatesAutoresizingMaskIntoConstraints = false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        managedContext.delete(progressObjects[indexPath.row])
        
        for progress in progressObjects {
            if progress.value(forKey: "order") as! Int > progressObjects[indexPath.row].value(forKey: "order") as! Int + 1 {
                let progressToReduce = progress.value(forKey: "order") as! Int - 1
                progress.setValue(progressToReduce, forKey: "order")
            } else {
                // return
                let progressToReduce = progress.value(forKey: "order") as! Int - 1
                progress.setValue(progressToReduce, forKey: "order")
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
        print("row is deleted")
        
        do {
            if managedContext.hasChanges {
                try managedContext.save()
//                self.progressTV.performBatchUpdates({
//                    self.progressTV.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
//                }, completion: nil)
                progressTV.reloadData()
                // fetchData()
            }
        } catch {
            print("Something wrong on deleting the progress")
        }
    }
    
    @objc func openVCToAddProgress(sender: UIButton!) {
        print("Floating button clicked!")
        self.navigationController?.pushViewController(AddProgressVC(), animated: true)
    }
    
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
        
        self.saveProgress(name: textToSave)
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
        // code to add a new progress:
        print("added ")
        
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
    
    
    
    // MARK: - progress calculating
    
    func calculateHours(start: Date, end: Date) -> DateComponents {
        
        let hoursToEnd = userCalendar.dateComponents([.hour], from: start, to: end)
        
        return hoursToEnd
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

