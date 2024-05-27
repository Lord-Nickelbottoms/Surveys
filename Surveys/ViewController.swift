//
//  ViewController.swift
//  Surveys
//
//  Created by Nizaam Haffejee on 2024/05/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
//MARK: - IBOutlets
    
    @IBOutlet var fullNameTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var birthDatePicker: UIDatePicker!
    @IBOutlet var contactTextField: UITextField!
    
    @IBOutlet var pizzaCheckbox: UIButton!
    @IBOutlet var pastaCheckbox: UIButton!
    @IBOutlet var papAndWorsCheckbox: UIButton!
    @IBOutlet var otherCheckbox: UIButton!
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    
    private var fullName = ""
    private var foodPreference = ""
    private var email = ""
    private var birthDate = Date()
    private var contactNumber = ""
    private var surveyQuestions = ["I like to watch movies", "I like to listen to radio", "I like to eat out", "I like to watch TV"]
    
    var dictionary = ["I like to watch movies" : "", "I like to listen to radio" : "", "I like to eat out" : "", "I like to watch TV" : ""]
    
    var questions = [String]()
    var answers = [String]()
    
//MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.layer.borderWidth = 1.0
        label2.layer.borderWidth = 1.0
        label3.layer.borderWidth = 1.0
        label4.layer.borderWidth = 1.0
        label5.layer.borderWidth = 1.0
        
        tableView.delegate = self
        tableView.dataSource = self
        
        pizzaCheckbox.addTarget(self, action: #selector(checkboxSelection(_:)), for: .touchUpInside)
        pastaCheckbox.addTarget(self, action: #selector(checkboxSelection(_:)), for: .touchUpInside)
        papAndWorsCheckbox.addTarget(self, action: #selector(checkboxSelection(_:)), for: .touchUpInside)
        otherCheckbox.addTarget(self, action: #selector(checkboxSelection(_:)), for: .touchUpInside)
    }
    
    private func formatDate(dateToFormat date: Date) -> Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.year, .month, .day], from: date)
        components.day! += 1
        
        return calender.date(from: components)!
    }
    
    @objc func checkboxSelection(_ sender: UIButton) {
        pizzaCheckbox.isSelected = false
        pastaCheckbox.isSelected = false
        papAndWorsCheckbox.isSelected = false
        otherCheckbox.isSelected = false
        
        pizzaCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        pastaCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        papAndWorsCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        otherCheckbox.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
        
        sender.isSelected = true
        
        if sender.isSelected == true {
            sender.setImage(UIImage(systemName: "checkmark.square.fill"), for: .selected)
            
            switch sender {
                case pizzaCheckbox:
                    foodPreference = "Pizza"
                    
                case pastaCheckbox:
                    foodPreference = "Pasta"
                    
                case papAndWorsCheckbox:
                    foodPreference = "Pap and Wors"
                    
                default:
                    foodPreference = "Other"
            }
        }
    }
    
//MARK: - IBActions
    
    @IBAction func submitData(_ sender: UIButton) {
        if fullNameTextField.text == "", emailTextField.text == "", contactTextField.text == "", dictionary.values.contains(where: { $0 == "" }) {
            let alert = UIAlertController(title: "Error!", message: "Personal details cannot be empty.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
            self.present(alert, animated: true)
        } else {
            fullName = fullNameTextField.text ?? ""
            email = emailTextField.text ?? ""
            contactNumber = contactTextField.text ?? ""
            birthDate = formatDate(dateToFormat: birthDatePicker.date)
        }
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        birthDate = sender.date
    }

//MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else{return UITableViewCell()}
        cell.setupCell(surveyQuestions[indexPath.row])
        cell.surveyData = {[weak self] data in
            
            for (key, value) in data {
                self?.dictionary[key] = value
            }
        }
        return cell
    }
}
