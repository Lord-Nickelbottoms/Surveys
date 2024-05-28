//
//  SurveyResultsViewController.swift
//  Surveys
//
//  Created by Nizaam Haffejee on 2024/05/28.
//

import UIKit
import CoreData

class SurveyResultsViewController: UIViewController {
    
    @IBOutlet var numberOfSurveys: UILabel!
    @IBOutlet var averageAge: UILabel!
    @IBOutlet var oldestPerson: UILabel!
    @IBOutlet var youngestPerson: UILabel!
    @IBOutlet var likesPizza: UILabel!
    @IBOutlet var likesPasta: UILabel!
    @IBOutlet var likesPapAndWors: UILabel!
    @IBOutlet var likesMovies: UILabel!
    @IBOutlet var likesRadio: UILabel!
    @IBOutlet var likesEatOut: UILabel!
    @IBOutlet var likesTelevision: UILabel!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var items = [Survey]()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func getAllData() {
        do {
            items = try context.fetch(Survey.fetchRequest())
        } catch {
            fatalError("Error fetching DB")
        }
    }
    
    
    @IBAction func returnTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
