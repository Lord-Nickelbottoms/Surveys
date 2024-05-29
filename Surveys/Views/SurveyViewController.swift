//
//  SurveyViewController.swift
//  Surveys
//
//  Created by Nizaam Haffejee on 2024/05/23.
//

import UIKit
import CoreData

class SurveyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
    
//MARK: - Variables
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var fullName = ""
    private var foodPreference = ""
    private var email = ""
    private var birthDate = Date()
    private var contactNumber = ""
    private var surveyQuestions = ["I like to watch movies", "I like to listen to radio", "I like to eat out", "I like to watch TV"]
    
    private var dictionary = ["Movies" : "", "Radio" : "", "Eat out" : "", "TV" : ""]
    private var movie = ""
    private var radio = ""
    private var eat = ""
    private var television = ""
    private var models = [Survey]()
    
    var resetState = false
    
//MARK: - Functions

    override func viewDidLoad() {
        super.viewDidLoad()
        resetState = false
        
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
        
        getAllData()
    }
    
//MARK: - CoreData Functions
    
    func getAllData() {
        do {
            models = try context.fetch(Survey.fetchRequest())
        } catch {
            fatalError("Error fetching database")
        }
    }
    
    func createUserSurvey(name: String, email: String, dateOfBirth: Date, contactNumber: String, foodPreference: String, likesMovies: String, likesRadio: String, likesEatOut: String, likesTelevision: String) {
        let newSurveyItem = Survey(context: context)
        
        newSurveyItem.fullName = name
        newSurveyItem.email = email
        newSurveyItem.birthDate = dateOfBirth
        newSurveyItem.contactNumber = contactNumber
        newSurveyItem.foodPreference = foodPreference
        newSurveyItem.watchMovies = likesMovies
        newSurveyItem.listenRadio = likesRadio
        newSurveyItem.eatOut = likesEatOut
        newSurveyItem.watchTelevision = likesTelevision
        
        do {
            try context.save()
            getAllData()
        } catch let error {
            let alert = UIAlertController(title: "Save Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel))
            self.present(alert, animated: true)
        }
    }
    
    private func formatDate(dateToFormat date: Date) -> Date {
        let calender = Calendar.current
        var components = calender.dateComponents([.year, .month, .day], from: date)
        components.day! += 1
        
        return calender.date(from: components)!
    }
    
    private func resetScreen() {
        fullNameTextField.text = ""
        emailTextField.text = ""
        contactTextField.text = ""
        pizzaCheckbox.isSelected = false
        pastaCheckbox.isSelected = false
        papAndWorsCheckbox.isSelected = false
        otherCheckbox.isSelected = false
        
        resetState = true
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
            
            createUserSurvey(name: fullName, email: email, dateOfBirth: birthDate, contactNumber: contactNumber, foodPreference: foodPreference, likesMovies: movie, likesRadio: radio, likesEatOut: eat, likesTelevision: television)
            
            let alert = UIAlertController(title: "Success", message: "Information has been saved", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cool", style: .default))
            self.present(alert, animated: true)
            resetScreen()
        }
    }
    
    @IBAction func dateSelected(_ sender: UIDatePicker) {
        birthDate = sender.date
    }
    
    
    @IBAction func viewResultsTapped(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toResults", sender: self)
    }
    
//MARK: - TableView
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        cell.setupCell(surveyQuestions[indexPath.row])
        
        cell.surveyData = {[weak self] data in
            for (key, value) in data {
                self?.dictionary[key] = value
                
                switch key {
                    case "I like to watch movies":
                        self?.movie = value
                        
                    case "I like to listen to radio":
                        self?.radio = value
                        
                    case "I like to eat out":
                        self?.eat = value
                        
                    case "I like to watch TV":
                        self?.television = value
                        
                    default:
                        break
                }
            }
        }
        
        if resetState {
            cell.resetCells = true
        }
        return cell
    }
}
