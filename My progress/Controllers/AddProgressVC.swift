//
//  AddProgressVC.swift
//  My progress
//
//  Created by Kovs on 15.08.2022.
//

import UIKit
import SnapKit
import ObjectiveC

class AddProgressVC: UIViewController {
    
    var mainVC = ViewController()
    
    lazy var scrollPage = UIScrollView()
    lazy var stackView = UIStackView()
    let saveButton = UIButton(type: .roundedRect)
    
    lazy var datePickerStart = UIDatePicker()
    lazy var datePickerEnd = UIDatePicker()
    var dateStart = Date()
    var dateEnd = Date()
    
    lazy var nameField = UITextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width - 40, height: 30))
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         if #available(iOS 13.0, *) {
              navigationController?.navigationBar.setNeedsLayout()
         }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = navigationController?.navigationItem.backBarButtonItem
        
//        self.navigationItem.title = "Add"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationItem.leftBarButtonItem = backButton
        
        self.view.backgroundColor = .white
        // stackView.backgroundColor = .gray
        
        scrollPage.makeScrollPage()
        
        /// scrollPage.contentSize = CGSize(width: Int(self.view.frame.size.width), height: 100)
        
        stackView.makeStackView()

        
        // MARK: - platform for views:
        view.addSubview(scrollPage)
        scrollPage.addSubview(stackView)
        
        // scrollPage.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        scrollPage.placeScrollPage(view: view)
        
        stackView.placeStackView(view: view, scrollPage: scrollPage)

        // self.view = view
        
        
        
        // MARK: - stack's pbjects:
        for _ in 0..<2 {
            let circle = UIView()
            let label = UILabel()
            
            circle.translatesAutoresizingMaskIntoConstraints = true
            label.translatesAutoresizingMaskIntoConstraints = false
            
            label.text = "Hello world!"
            label.textColor = .white
            
            circle.snp.makeConstraints { (circle) -> Void in
                circle.width.equalTo(150)
                circle.height.equalTo(50)
            }
            // circle.heightAnchor.constraint(equalToConstant: 50).isActive = true
            // circle.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
            circle.backgroundColor = .gray
            circle.layer.cornerRadius = 24
            circle.addSubview(label)
            
            label.snp.makeConstraints { (lab) -> Void in
                lab.centerX.equalTo(circle)
                lab.centerY.equalTo(circle)
            }
            
            stackView.addArrangedSubview(circle)
        }
        
        // MARK: - Date picker start
        datePickerStart.tintColor = .red
        datePickerStart.datePickerMode = .date
        datePickerStart.setDate(dateStart, animated: true)
        
        stackView.addArrangedSubview(datePickerStart)
        
        // MARK: - Date picker end
        datePickerEnd.tintColor = .blue
        datePickerEnd.setDate(dateEnd, animated: true)
        datePickerEnd.datePickerMode = .date
        
        stackView.addArrangedSubview(datePickerEnd)
        
        // MARK: - TextField for name
        nameField.placeholder = "My Progress name"
        nameField.borderStyle = .roundedRect
        nameField.backgroundColor = UIColor.white
        nameField.font = .systemFont(ofSize: 17, weight: .heavy)
        
        stackView.addArrangedSubview(nameField)
        
        // MARK: - Note view
        
        // MARK: - Save Button
        saveButton.setTitle("Save", for: .normal)
        saveButton.addAction(UIAction(title: "Save", handler: { [self] _ in
            guard let words = nameField.text else { return }
            print("\(words), \(datePickerEnd.date)")
            // mainVC.createNewProgress(name: words, dateEnd: datePickerEnd.date, value: 1, progress: 0)
            print("wow")
            dismiss(animated: true)
        }), for: .touchUpInside)
        
        stackView.addArrangedSubview(saveButton)
        
    }
    // end of viewDidLoad()
    
}
