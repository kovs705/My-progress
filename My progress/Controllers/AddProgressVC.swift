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
        
        
        createSkelet(stackView)
        
        configurePicker(picker: datePickerStart, date: dateStart, stackView: stackView, type: true)
        
        configurePicker(picker: datePickerEnd, date: dateEnd, stackView: stackView, type: false)
        
        configureNameField(nameField, stackView)
        
        // MARK: - Save Button
        saveButton.setTitle("Save", for: .normal)
        saveButton.addAction(UIAction(title: "Save", handler: { [self] _ in
            guard let nameOfProgress = nameField.text else { return }
            mainVC.createNewProgress(name: nameOfProgress, dateEnd: datePickerEnd.date + 1, dateStart: datePickerStart.date + 1)
            print("wow")
            dismiss(animated: true)
        }), for: .touchUpInside)
        
        stackView.addArrangedSubview(saveButton)
        
    }
    // end of viewDidLoad()
    
}


// MARK: - TextFields
func configureNameField(_ nameField: UITextField, _ stackView: UIStackView) {
    nameField.placeholder = "My Progress name"
    nameField.borderStyle = .roundedRect
    nameField.backgroundColor = UIColor.white
    nameField.font = .systemFont(ofSize: 17, weight: .heavy)
    
    stackView.addArrangedSubview(nameField)
}


// MARK: - Pickers
func configurePicker(picker: UIDatePicker, date: Date, stackView: UIStackView, type: Bool) { // start - true
    picker.tintColor = type ? .red : .blue
    picker.datePickerMode = .date
    picker.setDate(date, animated: true)
    
    stackView.addArrangedSubview(picker)
}


// MARK: - Two placeholders on top
func createSkelet(_ stackView: UIStackView) {
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
}
