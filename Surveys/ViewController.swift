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
    @IBOutlet var birthDateTextField: UITextField!
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
    
    private var surveyQuestions = ["I like to watch movies", "I like to listen to radio", "I like to eat out", "I like to watch TV"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        label1.layer.borderWidth = 1.0
        label2.layer.borderWidth = 1.0
        label3.layer.borderWidth = 1.0
        label4.layer.borderWidth = 1.0
        label5.layer.borderWidth = 1.0
        
        tableView.delegate = self
        tableView.dataSource = self
    }

//MARK: - TableView functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return surveyQuestions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CustomTableViewCell else{return UITableViewCell()}
        
        cell.setupCell(surveyQuestions[indexPath.row])
        
        return cell
    }
}
