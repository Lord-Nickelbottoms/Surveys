//
//  ViewController.swift
//  Surveys
//
//  Created by Nizaam Haffejee on 2024/05/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    @IBOutlet var headerView: UIView!
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var emptyLabel: UILabel!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!

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


}

