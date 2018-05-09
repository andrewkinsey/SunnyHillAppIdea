//
//  ViewController.swift
//  SunnyHillAppIdeaSolo
//
//  Created by Andrew James Kinsey on 4/29/18.
//  Copyright © 2018 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet var commentTextFields: [UITextField]!
    @IBOutlet var segmentedControllers: [UISegmentedControl]!
    @IBOutlet weak var teacherModeButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    var password = "test"
    var scores = [Int]() {
        didSet {
            defaults.set(scores, forKey: "SCORE")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let savedData = defaults.object(forKey: "SCORE") as? [Int] {
            scores = savedData
        }
        
        for i in 0..<segmentedControllers.count
        {
           segmentedControllers[i].selectedSegmentIndex = scores[i]
        }
        
        totalScores()
    }
    
    func totalScores()
    {
            for i in 0...9
            {
                if scores[0+(3*i)].signum() != -1 && scores[1+(3*i)].signum() != -1 && scores[2+(3*i)].signum() != -1
                {
                    let totalValue = scores[0+(3*i)] + scores[1+(3*i)] + scores[2+(3*i)]
                    scoreLabels[i].text = "\(totalValue)"
                }
                else
                {
                    scoreLabels[i].text = ""
                }
            }
    }
    
    @IBAction func editButtonTapped(_ sender: Any)
    {
        if teacherModeButton.title == "Edit"
        {
            clearButton.isEnabled = true
            let alert = UIAlertController(title: "Enter Teacher Password", message: nil, preferredStyle: .alert)
            alert.addTextField { (passwordTextField) in
            }
            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
                let userEnteredPassword = alert.textFields![0] as UITextField
                if userEnteredPassword.text == self.password
                {
                    for i in 0..<self.segmentedControllers.count
                    {
                        self.segmentedControllers[i].isEnabled = true
                    }
                    for i in 0..<self.commentTextFields.count
                    {
                        self.commentTextFields[i].isEnabled = true
                    }
                    self.teacherModeButton.title = "Save"
                }
            }))
            present(alert, animated: true, completion: nil)
        }
        else if teacherModeButton.title == "Save"
        {
            scores.removeAll()
            clearButton.isEnabled = false
            for i in 0..<segmentedControllers.count
            {
                segmentedControllers[i].isEnabled = false
                scores.append(segmentedControllers[i].selectedSegmentIndex)
            }
            for i in 0..<commentTextFields.count
            {
                commentTextFields[i].isEnabled = false
            }
            teacherModeButton.title = "Edit"
            totalScores()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any)
    {
        for i in 0..<segmentedControllers.count
        {
            segmentedControllers[i].selectedSegmentIndex = -1
        }
        for i in 0..<commentTextFields.count
        {
            commentTextFields[i].text = ""
        }
    }
    

}

