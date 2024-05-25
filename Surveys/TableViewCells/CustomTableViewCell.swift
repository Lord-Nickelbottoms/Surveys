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
    }

}
