//
//  MoviesTableViewCell.swift
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

    func setupCell(_ surveyText: String) {
        self.surveyText.text = surveyText
        
        self.strongAgree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.agree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.neutral.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.disagree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
        self.strongDisagree.addTarget(self, action: #selector(radioButtonSelection(_:)), for: .touchUpInside)
    }
    
    func resetCells() {
        strongAgree.setImage(UIImage(systemName: "circle"), for: .selected)
        agree.setImage(UIImage(systemName: "circle"), for: .selected)
        neutral.setImage(UIImage(systemName: "circle"), for: .selected)
        disagree.setImage(UIImage(systemName: "circle"), for: .selected)
        strongAgree.setImage(UIImage(systemName: "circle"), for: .selected)
    }

    @objc func radioButtonSelection(_ sender: UIButton) {
        strongAgree.isSelected = false
        agree.isSelected = false
        neutral.isSelected = false
        disagree.isSelected = false
        strongDisagree.isSelected = false
        
        
        sender.isSelected = true
        
        if sender.isSelected == true {
            sender.setImage(UIImage(systemName: "circle.fill"), for: .selected)
        } else {
            sender.setImage(UIImage(systemName: "circle"), for: .selected)
        }
    }
}
