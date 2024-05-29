    //
    //  CustomTableViewCell.swift
    //  Surveys
    //
    //  Created by Nizaam Haffejee on 2024/05/24.
    //

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet private var surveyText: UILabel!
    @IBOutlet var strongAgree: UIButton!
    @IBOutlet var agree: UIButton!
    @IBOutlet var neutral: UIButton!
    @IBOutlet var disagree: UIButton!
    @IBOutlet var strongDisagree: UIButton!
    
    var surveyData: (([String: String]) -> Void)?
    var dictionary = [String: String]()
    
    func setupCell(_ surveyText: String) {
        self.surveyText.text = surveyText
        self.strongAgree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.agree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.neutral.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.disagree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.strongDisagree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
    }
    
    @objc func radioButtonSelection(_ sender: UIButton) {
        strongAgree.isSelected = false
        agree.isSelected = false
        neutral.isSelected = false
        disagree.isSelected = false
        strongDisagree.isSelected = false
        
        strongAgree.setImage(UIImage(systemName: "circle"), for: .normal)
        agree.setImage(UIImage(systemName: "circle"), for: .normal)
        neutral.setImage(UIImage(systemName: "circle"), for: .normal)
        disagree.setImage(UIImage(systemName: "circle"), for: .normal)
        strongAgree.setImage(UIImage(systemName: "circle"), for: .normal)
        
        
        sender.isSelected = true
        
        if sender.isSelected == true {
            sender.setImage(UIImage(systemName: "circle.fill"), for: .selected)
            
                switch sender {
                    case strongAgree:
                        dictionary[surveyText.text ?? ""] = "Strong Agree"
                        
                    case agree:
                            dictionary[surveyText.text ?? ""] = "Agree"
                        
                    case neutral:
                            dictionary[surveyText.text ?? ""] = "Neutral"
                        
                    case disagree:
                            dictionary[surveyText.text ?? ""] = "Disagree"
                        
                    case strongDisagree:
                            dictionary[surveyText.text ?? ""] = "Strong Disagree"
                        
                    default:
                        break
                }
            
            if surveyData != nil {
                surveyData?(dictionary)
            }
        }
    }
    
    func resetCells() {
        strongAgree.isSelected = false
        agree.isSelected = false
        neutral.isSelected = false
        disagree.isSelected = false
        strongDisagree.isSelected = false
    }
}
