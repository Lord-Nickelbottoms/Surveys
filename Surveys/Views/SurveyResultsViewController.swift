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
    
//MARK: - UI Update
    
    private func updateUI() {
        DispatchQueue.main.async { [self] in
            numberOfSurveys.text = totalAmountOfSurveys
            averageAgeLabel.text = "\(String(format: "%.1f", calculateAverageAge())) years old."
            oldestPerson.text = "\(calculateOldestAge()) years old."
            youngestPerson.text = "\(calculateYoungestAge()) years old."
            
            likesPizza.text = "%\(pizzaPercentage())"
            likesPasta.text = "%\(pastaPercentage())"
            likesPapAndWors.text = "%\(papAndWorsPercentage())"
            
            likesMovies.text = "Avg: \(String(format: "%.1f", movieLikeAverage())) (\(movieLikePercentage)%)"
            likesRadio.text = "Avg: \(String(format: "%.1f", radioLikeAverage())) (\(radioLikePercentage)%)"
            likesEatOut.text = "Avg: \(String(format: "%.1f", eatOutLikeAverage())) (\(eatOutLikePercentage)%)"
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
    
//MARK: - Age Calculations
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
    
    private func calculateAverageAge() -> Double {
        let birthDates = fetchBirthDates()
        let ages = calculateAges(dates: birthDates)
        let average = ageAverage(ages: ages)
        
        return average
    }
    
//MARK: - Food Preferences
    
    private func pizzaPercentage() -> String {
        var pizzaLikeAmount = 0
        
        for item in surveyItems {
            if item.foodPreference == "Pizza" {
                pizzaLikeAmount += 1
            }
        }
        
        let percentage = (Double(pizzaLikeAmount) / Double(surveyItems.count)) * 100
        return String(format: "%.1f", percentage)
    }
    
    private func pastaPercentage() -> String {
        var pastaLikeAmount = 0
        
        for item in surveyItems {
            if item.foodPreference == "Pasta" {
                pastaLikeAmount += 1
            }
        }
        
        let percentage = (Double(pastaLikeAmount) / Double(surveyItems.count)) * 100
        return String(format: "%.1f", percentage)
    }
    
    private func papAndWorsPercentage() -> String {
        var papAndWorsLikeAmount = 0
        
        for item in surveyItems {
            if item.foodPreference == "Pap and Wors" {
                papAndWorsLikeAmount += 1
            }
        }
        
        let percentage = (Double(papAndWorsLikeAmount) / Double(surveyItems.count)) * 100
        return String(format: "%.1f", percentage)
    }
    
//MARK: - Ratings
    
    private func movieLikeAverage() -> Double {
        var rating = 0
        var amountOfRatings = 0
        var strongAgree = 0
        var agree = 0
        
        for item in surveyItems {
            amountOfRatings = item.watchMovies?.count ?? 0
            if item.watchMovies == "Strong Agree"  {
                strongAgree += 1
            } else if item.watchMovies == "Agree" {
                agree += 2
            }
        }
        
        rating = strongAgree + agree
        return Double(rating) / Double(amountOfRatings)
    }
    
    private var movieLikePercentage: String {
        return String(format: "%.1f", movieLikeAverage() * 100)
    }
    
    private func radioLikeAverage() -> Double {
        var rating = 0
        var amountOfRatings = 0
        var strongAgree = 0
        var agree = 0
        
        for item in surveyItems {
            amountOfRatings = item.listenRadio?.count ?? 0
            if item.listenRadio == "Strong Agree"  {
                strongAgree += 1
            } else if item.listenRadio == "Agree" {
                agree += 2
            }
        }
        
        rating = strongAgree + agree
        return Double(rating) / Double(amountOfRatings)
    }
    
    private var radioLikePercentage: String {
        return String(format: "%.1f", radioLikeAverage() * 100)
    }
    
    private func eatOutLikeAverage() -> Double {
        var rating = 0
        var amountOfRatings = 0
        var strongAgree = 0
        var agree = 0
        
        for item in surveyItems {
            amountOfRatings = item.eatOut?.count ?? 0
            if item.eatOut == "Strong Agree"  {
                strongAgree += 1
            } else if item.eatOut == "Agree" {
                agree += 2
            }
        }
        
        rating = strongAgree + agree
        return Double(rating) / Double(amountOfRatings)
    }
    
    private var eatOutLikePercentage: String {
        return String(format: "%.1f", eatOutLikeAverage() * 100)
    }
}
