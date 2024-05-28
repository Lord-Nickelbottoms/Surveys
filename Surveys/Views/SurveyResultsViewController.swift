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
    @IBOutlet var averageAgeLabel: UILabel!
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
    
    var surveyItems = [Survey]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllData()
        updateUI()
    }
    
    private func updateUI() {
        DispatchQueue.main.async { [self] in
            numberOfSurveys.text = totalAmountOfSurveys
            averageAgeLabel.text = "\(calculateAverageAge()) years old."
            oldestPerson.text = "\(calculateOldestAge()) years old."
            youngestPerson.text = "\(calculateYoungestAge()) years old."
        }
    }
    
    
    @IBAction func returnTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
//MARK: - CoreData Operations
    
    private func getAllData() {
        do {
            surveyItems = try context.fetch(Survey.fetchRequest())
        } catch let error {
            fatalError(error.localizedDescription)
        }
    }
    
    private func fetchBirthDates() -> [Date] {
        do {
            let data = try context.fetch(Survey.fetchRequest())
            let birthDates = data.compactMap { $0.value(forKey: "birthDate") as? Date }
            return birthDates
        } catch {
            fatalError("Error fetching BirthDates")
        }
    }
    
    private var totalAmountOfSurveys: String {
        return String(surveyItems.count)
    }
    
    // Age calculations
    private var ageAverage: String {
        let averageAge = calculateAverageAge()
        return String(averageAge)
    }
    
    private func oldestAge(ages: [Int]) -> Int {
        return ages.max() ?? 0
    }
    
    private func calculateOldestAge() -> Int {
        let birthDates = fetchBirthDates()
        let ages = calculateAges(dates: birthDates)
        let oldestAge = oldestAge(ages: ages)
        return oldestAge
    }
    
    private func youngestAge(ages: [Int]) -> Int {
        return ages.min() ?? 0
    }
    
    private func calculateYoungestAge() -> Int {
        let birthDates = fetchBirthDates()
        let ages = calculateAges(dates: birthDates)
        let youngestAge = youngestAge(ages: ages)
        return youngestAge
    }
    
    private func ageAverage(ages: [Int]) -> Double {
        guard !ages.isEmpty else { return 0.0 }
        
        let totalAge = ages.reduce(0, +)
        return Double(totalAge) / Double(ages.count)
    }
    
    private func calculateAges(dates: [Date]) -> [Int] {
        let calendar = Calendar.current
        let currentDate = Date()
        
        let ages = dates.map { birthDate -> Int in
            let ageComponents = calendar.dateComponents([.year], from: birthDate, to: currentDate)
            return ageComponents.year ?? 0
        }
        
        return ages
    }
    
    private func calculateAverageAge() -> String {
        let birthDates = fetchBirthDates()
        let ages = calculateAges(dates: birthDates)
        let average = ageAverage(ages: ages)
        
        return String(average)
    }
}
